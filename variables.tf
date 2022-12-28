# Path: variables.tf
# create variables for main.tf with default values
variable "project" {
  type        = string
  description = "The ID of the project in which the resource belongs."
  default     = "domu-project"
}
# variable region Jakarta
variable "region" {
  type        = string
  description = "The region of the resource."
  default     = "asia-southeast2"
}
# variable zone Jakarta
variable "zone" {
  type        = string
  description = "The zone of the resource."
  default     = "asia-southeast2-a"
}
# variable name
variable "name" {
  type        = string
  description = "The name of the resource."
  default     = "domu-instance"
}
# variable machine type N2
variable "machine_type" {
  type        = string
  description = "The machine type of the resource."
  default     = "n2-standard-1"
}
# variable tags
variable "tags" {
  type        = list(string)
  description = "The tags of the resource."
  default     = ["http-server", "https-server"]
}
# variable metadata startup script
variable "metadata_startup_script" {
  type        = string
  description = "The metadata startup script of the resource."
  default     = "apt-get update && apt-get install -y apache2 && service apache2 start"
}
# variable image ubuntu 20.04 lts
variable "image" {
  type        = string
  description = "The image of the resource."
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}
# variable disk size 10GB
variable "disk_size" {
  type        = number
  description = "The disk size of the resource."
  default     = 10
}
# variable disk type standard
variable "disk_type" {
  type        = string
  description = "The disk type of the resource."
  default     = "pd-standard"
}
# variable gcp crediential json
variable "GCP_ACCESS_TOKEN" {
  type        = string
  description = "The gcp credential of the resource."
  default     = "./google-credentials.json"
}
# variable source
variable "source" {
  type        = string
  description = "The source of the resource."
  default     = "path/to/local/folder"
}
# variable destination
variable "destination" {
  type        = string
  description = "The destination of the resource."
  default     = "/path/on/server"
}
