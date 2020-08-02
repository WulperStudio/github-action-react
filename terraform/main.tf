variable "token" {}

variable "app_name" {}

variable "ssh_key_fingerprint" {}

variable "private_key_do" {}

variable "private_key_repo" {}

variable "env_file" {}

variable "project_name" {}

provider "digitalocean" {
  token = var.token
}

resource "digitalocean_droplet" "app" {
  name        = var.app_name
  image       = "ubuntu-18-04-x64"
  region      = "nyc1"
  size        = "s-1vcpu-1gb"
  resize_disk = false
  backups     = false
  ssh_keys    = [var.ssh_key_fingerprint]

  connection {
    type        = "ssh"
    private_key = file(var.private_key_do)
    user        = "root"
    timeout     = "2m"
    host        = self.ipv4_address
  }

  provisioner "file" {
    source      = var.private_key_do
    destination = "/root/.ssh/id_rsa"
  }

  provisioner "file" {
    source      = var.private_key_repo
    destination = "/root/.ssh/git_repo"
  }

  provisioner "file" {
    source      = var.env_file
    destination = "/home/.env"
  }

  provisioner "file" {
    source      = "../scripts/ssh.conf"
    destination = "/root/.ssh/config"
  }

  provisioner "file" {
    source      = "../scripts/deploy.mk"
    destination = "/home/deploy.mk"
  }

  provisioner "file" {
    source      = "../scripts/build-server.sh"
    destination = "/tmp/build-server.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/build-server.sh",
      "/tmp/build-server.sh args",
    ]
  }
}

resource "digitalocean_project" "project" {
  name        = var.project_name
  description = "This is my project in DigitalOcean"
  purpose     = "Web Application"
  environment = "Development"
  resources   = [digitalocean_droplet.app.urn]
}
