variable "region" {
  description = "AWS region"
  type = string
}

variable "project" {
  description = "project name - i.e ."
  type = string
}

variable "namespace" {
  type = string
  default = "geniusee-task"
}

variable "deployment_name" {
  type = string
  default = "apache"
}

variable "port" {
  type = number
  default = 80
}

variable "count_deployment" {
  type = number
  default = 1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "geniusee-devops-task"
    "Owner"       = "Dmytro Boiko"
  }
}