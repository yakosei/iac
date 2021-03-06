yum -y install fuse
curl -kLR https://github.com/kahing/goofys/releases/download/v0.0.9/goofys -o /tmp/goofys
chmod 755 /tmp/goofys
\mv /tmp/goofys /usr/bin/goofys

cat <<'__EOD__'
var_prefix_org=$(date +'-%Y%m%d-%H%M%S.org')
var_conf=/etc/fstab
var_bin=/usr/bin/goofys
S3MOUNTDIR=''
S3BUCKET=''

[ -d $S3MOUNTDIR ] || mkdir -p $S3MOUNTDIR
goofys --region $(curl -s --connect-timeout 4 http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//') $S3BUCKET $S3MOUNTDIR
sleep 20
[ "$(df -P | grep $S3BUCKET)" ] || { echo 'mount $S3BUCKET failed.' && exit 1; }
\cp -p $var_conf $var_conf${var_prefix_org:?}
[ "$(grep "$S3BUCKET" $var_conf)" ] || echo -e "\n# $(date +'Edit %Y%m%d')\n$var_bin#$S3BUCKET\t$S3MOUNTDIR\tfuse\t_netdev,allow_other,--file-mode=0666\t0\t0" >>$var_conf
[ "$(diff $var_conf $var_conf$var_prefix_org)" ] || \mv -f $var_conf$var_prefix_org $var_conf
__EOD__
