function aws-ec2-ls {
  aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$1" \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,IP:PublicIpAddress,State:State.Name}' \
    --output table \
    --no-cli-pager
}
