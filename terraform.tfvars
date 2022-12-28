# define all the variables that are used in the program
project = "project-1"
region = "asia-southeast2"
zone = "asia-southeast2-a"
name = "domu-instance-1"
machine_type = "n2-standard-1"
tags = ["http-server", "https-server"]
metadata_startup_script = "apt-get update && apt-get install -y apache2 && service apache2 start"
image = "ubuntu-os-cloud/ubuntu-2004-lts"
disk_size = 15
disk_type = "pd-standard"
GCP_ACCESS_TOKEN = "./google-credentials.json"
source-data = "path/to/local/folder"
destination-data = "/path/on/server"