yum -y install fuse
curl -kLR https://github.com/kahing/goofys/releases/download/v0.0.9/goofys -o /tmp/goofys
chmod 755 /tmp/goofys
\mv /tmp/goofys /usr/bin/goofys

cat <<'__EOD__'
[ -d $S3MOUNTDIR ] || mkdir -p $S3MOUNTDIR
goofys --region $(curl -s --connect-timeout 4 http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//') $S3BUCKET $S3MOUNTDIR
sleep 20
[ "$(df | grep $S3BUCKET)" ] || { echo 'mount $S3BUCKET failed.' && exit 1; }
fstab=/etc/fstab
cp -p $fstab $fstab$prefix
[ "$(grep "$S3BUCKET" $fstab)" ] || echo -e "\n# $edit_comment\n$goofys_bin#$S3BUCKET\t$S3MOUNTDIR\tfuse\t_netdev,allow_other,--file-mode=0666\t0\t0" >>$fstab
[ "$(diff $fstab $fstab$prefix)" ] || rm -f $fstab$prefix
__EOD__
