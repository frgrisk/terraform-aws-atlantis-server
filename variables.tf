variable "hostname" {
  type        = string
  description = "Hostname to use for the Atlantis server"
}

variable "keypair_name" {
  type        = string
  description = "Name of the keypair to use for the Atlantis server"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the Atlantis server"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the Atlantis server"
  default     = "t3.nano"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile to use for the Atlantis server"
  default     = null
}

variable "disable_api_stop" {
  type        = bool
  description = "Disable the API stop endpoint"
  default     = true
}

variable "disable_api_termination" {
  type        = bool
  description = "Disable the API termination endpoint"
  default     = true
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach to the Atlantis server"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to deploy the Atlantis server to"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the Atlantis server"
  default     = true
}

variable "github_app_id" {
  type        = string
  description = "GitHub app ID to use for the Atlantis server"
}

variable "github_app_key" {
  type        = string
  description = "GitHub app key to use for the Atlantis server"
}

variable "github_webhook_secret" {
  type        = string
  description = "GitHub webhook secret to use for the Atlantis server"
}

variable "atlantis_web_username" {
  type        = string
  description = "Atlantis web username to use for the Atlantis server"
}

variable "atlantis_web_password" {
  type        = string
  description = "Atlantis web password to use for the Atlantis server"
}

variable "repo_allowlist" {
  type        = string
  description = "List of repos to allow for the Atlantis server"
  default     = "*"
}

variable "atlantis_version" {
  type        = string
  description = "Atlantis version to use for the Atlantis server"
  default     = "v0.30.0"
}

variable "atlantis_checksum" {
  type        = string
  description = "Atlantis checksum to use for the Atlantis binary"
  default     = "ff341186e001100cb295407b423ef447377d71e8cd90087afb687daec85c977c"
}

variable "github_org" {
  type        = string
  description = "GitHub org to use for the Atlantis server"
}

variable "certbot_email" {
  type        = string
  description = "Email to use for the certbot certificate"
}

variable "additional_tags" {
  description = "Additional tags to apply to the instance"
  type        = map(string)
  default     = {}
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
  default     = 10
}

variable "repo_config_json" {
  description = "JSON string of the repo config to use for the Atlantis server"
  type        = string
  default     = null
}

variable "test_cert" {
  description = "Use a test cert for the Atlantis server"
  type        = bool
  default     = false
}

variable "spot_instance" {
  description = "Use a spot instance for the Atlantis server"
  type        = bool
  default     = false
}

variable "azure_auth" {
  description = "Azure auth to use for the Atlantis server"
  type = object({
    client_id       = string
    client_secret   = string
    subscription_id = string
    tenant_id       = string
  })
  default = null
}

variable "region" {
  description = "AWS region to deploy the Atlantis server"
  type        = string
  default     = null
}