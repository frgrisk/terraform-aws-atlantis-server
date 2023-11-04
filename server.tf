locals {
  instance_tags = merge(
    var.additional_tags,
    {
      Hostname = var.hostname
    },
  )
}

resource "aws_instance" "atlantis" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.keypair_name
  iam_instance_profile = var.iam_instance_profile

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination

  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  user_data = join("\n",
    [
      file("${path.module}/user_data_scripts/base.sh"),
      templatefile(
        "${path.module}/user_data_scripts/atlantis_install.sh.tftpl",
        {
          hostname         = var.hostname,
          app_id           = var.github_app_id,
          app_key          = var.github_app_key,
          webhook_secret   = var.github_webhook_secret,
          web_username     = var.atlantis_web_username,
          web_password     = var.atlantis_web_password,
          repo_allowlist   = var.repo_allowlist,
          version          = var.atlantis_version,
          checksum         = var.atlantis_checksum,
          gh_org           = var.github_org,
          certbot_email    = var.certbot_email,
          repo_config_json = var.repo_config_json,
          test_cert        = var.test_cert
        }
      ),
      "reboot now",
    ]
  )
  user_data_replace_on_change = true

  tags = local.instance_tags

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }
}
