yum -y install fuse
curl -kLR https://github.com/kahing/goofys/releases/download/v0.0.9/goofys -o /tmp/goofys
chmod 755 goofys
\mv /tmp/goofys /usr/bin/goofys
