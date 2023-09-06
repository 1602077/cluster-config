module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"

  name    = var.bastion_host_name
  project = var.project_id
  zone    = var.zone
  members = var.bastion_host_members

  image_family = "debian-11"
  machine_type = var.bastion_host_machine_type
  preemptible  = true

  network              = var.vpc_name
  subnet               = var.subnet_name
  external_ip          = false
  create_firewall_rule = true

  startup_script = <<EOF
  sudo apt install tinyproxy -y
  echo "Allow localhost" | sudo tee -a /etc/tinyproxy/tinyproxy.conf
  sudo service tinyproxy restart
  echo "tiny proxy configured"_script
  EOF
}
