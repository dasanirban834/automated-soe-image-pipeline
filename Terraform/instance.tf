resource "aws_iam_instance_profile" "test_profile" {
  name = "InstanceProfile"
  role = data.aws_iam_role.instance_role.name
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.ami_id.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  key_name                    = data.aws_key_pair.keypair.key_name
  security_groups             = [data.aws_security_group.sg.id, ]
  iam_instance_profile        = aws_iam_instance_profile.test_profile.name
  subnet_id                   = data.aws_subnet.subnet.id
  user_data                   = file("userdata.sh")

  root_block_device {
    volume_size = 15
    volume_type = "gp2"
  }
  tags = {
    "Name" = "GoldenImageVM"
  }
}