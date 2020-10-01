
data "google_compute_image" "centos_image" {
  name  = "centos-7-v20200910"
  project = "centos-cloud"
}

variable "vm_username" {
  type        = string
  description = "Username to SSH login"
}

resource "google_compute_firewall" "jenkins_firewall" {
  name    = "jenkins-firewall"
  network = google_compute_network.jenkis_network.name

  allow {
    protocol = "icmp"
  }


  allow {
    protocol = "tcp"
    ports    = ["80", "8080","22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "jenkis_network" {
  name = "jenkis-network"
}


resource "google_compute_instance" "vm_jenkins" {
  name         = "vm-jenkins"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["jenkins"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos_image.self_link
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.jenkis_network.self_link

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = "jenkins"
    ssh-keys = "${var.vm_username}:${file("key.pub")}"
  }

  
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

output "ip" {
  value = google_compute_instance.vm_jenkins.network_interface.0.access_config.0.nat_ip
}

