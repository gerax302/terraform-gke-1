variable "name" {
  default = "demo-cluster"
}
variable "project" {
  default = "test"
}

variable "location" {
  default = "us-central1"
}

variable "initial_node_count" {
  default = 1
  # up number multiplied by 3...3 zones for us-central
}

variable "machine_type" {
  default = "n1-standard-1"  
}

variable "name-node-pool" {

}
