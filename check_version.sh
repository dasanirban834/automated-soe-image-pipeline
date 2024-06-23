### Check Version of required tools
#!/bin/bash
echo 'Git_Version: `git -v`'
echo 'Terraform_Version: `terraform -v`'
echo 'Ansible_Version: `ansible --version`'
echo 'GitLab_Runner_Version: `gitlab-runner -version`'
echo 'AWSCLI_Version: `/usr/local/bin/aws --version`'

### Check required service status
systemctl status sshd
systemctl status gitlab-runner