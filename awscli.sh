curl -kLR https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python /tmp/get-pip.py
pip install awscli
rm -f /tmp/get-pip.py
