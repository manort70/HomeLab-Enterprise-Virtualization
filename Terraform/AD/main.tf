provider "ad" {
  winrm_hostname = "AD01.homelab.local"
  winrm_username = var.ad_user
  winrm_password = var.ad_password
  winrm_port     = 5986
  winrm_proto    = "https"
  krb_realm      = "HOMELAB.LOCAL"
}

resource "ad_computer" "splunk" {
  name                  = "SplunkServer"
  organizational_unit   = "OU=Servers,DC=homelab,DC=local"
}
