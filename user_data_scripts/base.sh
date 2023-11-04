#!/bin/bash
set -e
set -x
yum update -y
yum install -y git vim jq python3 unzip zsh

# Install AWS CLI if necessary
if ! command -v aws > /dev/null; then
  echo "The AWS CLI is not installed. Installing..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -i).zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
  rm -rfv aws*
fi

# umask
echo '#!/bin/bash' > /etc/profile.d/umask.sh
echo 'umask 002' >> /etc/profile.d/umask.sh
chmod a+x /etc/profile.d/umask.sh

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
instance_id=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
# shellcheck disable=SC2016
while [ -z "$HOSTNAME_TAG" ]
do
   HOSTNAME_TAG=$(aws ec2 describe-instances --instance-ids "$instance_id" --output text --query 'Reservations[*].Instances[*].Tags[?Key==`Hostname`].Value')
   echo "Waiting for Hostname tag to be set..."
   sleep 2
done
echo "Hostname tag is set to $HOSTNAME_TAG"
hostnamectl set-hostname --static "$HOSTNAME_TAG"
