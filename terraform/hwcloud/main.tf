provider "huaweicloud" {
  region = "ap-southeast-1"
}

data "huaweicloud_compute_flavors" "demo-iac-flavor" {
  availability_zone = var.default_az_name
  performance_type  = "normal"
  cpu_core_count    = 1
  memory_size       = 2
}

data "huaweicloud_images_image" "demo-iac-image" {
  name        = "CentOS 7.6 64bit"
  most_recent = true
}

resource "huaweicloud_compute_keypair" "demo-iac-keypair" {
  name     = "demo-iac-keypair"
  key_file = "private_key.pem"
}

resource "huaweicloud_compute_instance" "demo-iac-k8snode1" {
  name              = "demo-iac-k8snode1"
  key_pair          = huaweicloud_compute_keypair.demo-iac-keypair.name
  image_id          = data.huaweicloud_images_image.demo-iac-image.id
  flavor_id         = data.huaweicloud_compute_flavors.demo-iac-flavor.ids[0]
  availability_zone = var.default_az_name
  security_groups   = ["default"]

  network {
    uuid = var.default_subnet_id
  }
}

resource "huaweicloud_compute_instance" "demo-iac-k8snode2" {
  name              = "demo-iac-k8snode2"
  key_pair          = huaweicloud_compute_keypair.demo-iac-keypair.name
  image_id          = data.huaweicloud_images_image.demo-iac-image.id
  flavor_id         = data.huaweicloud_compute_flavors.demo-iac-flavor.ids[0]
  availability_zone = var.default_az_name
  security_groups   = ["default"]

  network {
    uuid = var.default_subnet_id
  }
}

resource "huaweicloud_compute_instance" "demo-iac-k8snode3" {
  name              = "demo-iac-k8snode3"
  key_pair          = huaweicloud_compute_keypair.demo-iac-keypair.name
  image_id          = data.huaweicloud_images_image.demo-iac-image.id
  flavor_id         = data.huaweicloud_compute_flavors.demo-iac-flavor.ids[0]
  availability_zone = var.default_az_name
  security_groups   = ["default"]

  network {
    uuid = var.default_subnet_id
  }
}

resource "huaweicloud_compute_instance" "demo-iac-vaultnode" {
  name              = "demo-iac-vaultnode"
  key_pair          = huaweicloud_compute_keypair.demo-iac-keypair.name
  image_id          = data.huaweicloud_images_image.demo-iac-image.id
  flavor_id         = data.huaweicloud_compute_flavors.demo-iac-flavor.ids[0]
  availability_zone = var.default_az_name
  security_groups   = ["default"]

  network {
    uuid = var.default_subnet_id
  }
}

resource "huaweicloud_vpc_eip" "demo-iac-ip1" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "demo-iac-bandwidth"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_vpc_eip" "demo-iac-ip2" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "demo-iac-bandwidth"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_vpc_eip" "demo-iac-ip3" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "demo-iac-bandwidth"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_vpc_eip" "demo-iac-ip4" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "demo-iac-bandwidth"
    size        = 1
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "associated1" {
  public_ip   = huaweicloud_vpc_eip.demo-iac-ip1.address
  instance_id = huaweicloud_compute_instance.demo-iac-k8snode1.id
}

resource "huaweicloud_compute_eip_associate" "associated2" {
  public_ip   = huaweicloud_vpc_eip.demo-iac-ip2.address
  instance_id = huaweicloud_compute_instance.demo-iac-k8snode2.id
}

resource "huaweicloud_compute_eip_associate" "associated3" {
  public_ip   = huaweicloud_vpc_eip.demo-iac-ip3.address
  instance_id = huaweicloud_compute_instance.demo-iac-k8snode3.id
}

resource "huaweicloud_compute_eip_associate" "associated4" {
  public_ip   = huaweicloud_vpc_eip.demo-iac-ip4.address
  instance_id = huaweicloud_compute_instance.demo-iac-vaultnode.id
}

