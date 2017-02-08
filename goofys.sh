yum -y install fuse
curl -kLR https://github.com/kahing/goofys/releases/download/v0.0.9/goofys -o /tmp/goofys
chmod 755 /tmp/goofys
\mv /tmp/goofys /usr/bin/goofys

cat <<'__EOD__'
[ -d $S3MOUNTDIR ] || mkdir -p $S3MOUNTDIR
goofys --region $aws_region $S3BUCKET $S3MOUNTDIR
sleep 20
[ "$(df | grep $S3BUCKET)" ] || halt
fstab=/etc/fstab
cp -p $fstab $fstab$prefix
[ "$(grep "$S3BUCKET" $fstab)" ] || echo -e "\n# $edit_comment\n$goofys_bin#$S3BUCKET\t$S3MOUNTDIR\tfuse\t_netdev,allow_other,--file-mode=0666\t0\t0" >>$fstab
[ "$(diff $fstab $fstab$prefix)" ] || rm -f $fstab$prefix
__EOD__
