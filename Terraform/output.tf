output "ami_id" {
  value = {
    id               = data.aws_ami.ami_id.image_id
    arn              = data.aws_ami.ami_id.arn
    image_loc        = data.aws_ami.ami_id.image_location
    state            = data.aws_ami.ami_id.state
    creation_date    = data.aws_ami.ami_id.creation_date
    image_type       = data.aws_ami.ami_id.image_type
    platform         = data.aws_ami.ami_id.platform
    owner            = data.aws_ami.ami_id.owner_id
    root_device_name = data.aws_ami.ami_id.root_device_name
    root_device_type = data.aws_ami.ami_id.root_device_type
  }
}

output "ec2_details" {
  value = {
    arn         = aws_instance.ec2.arn
    id          = aws_instance.ec2.id
    private_dns = aws_instance.ec2.private_dns
    private_ip  = aws_instance.ec2.private_ip
    public_dns  = aws_instance.ec2.public_dns
    public_ip   = aws_instance.ec2.public_ip

  }
}

output "key_id" {
  value = {
    id          = data.aws_key_pair.keypair.id
    fingerprint = data.aws_key_pair.keypair.fingerprint
  }
}

output "sg_id" {
  value = data.aws_security_group.sg.id
}

output "role_arn" {
  value = {
    arn = data.aws_iam_role.instance_role.arn
    id  = data.aws_iam_role.instance_role.id
  }
}