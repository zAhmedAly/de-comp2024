variable "credentials" {
  description = "my gcp credentials"
  default     = "/home/k247910/terraform_work/keys/my-creds.json"
}

variable "project" {
  description = "project name"
  default     = "dtc-de-course-01152024"
}

variable "region" {
  description = "region name"
  default     = "us-central1"
}

variable "location" {
  description = "project location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "my BigData Dataset name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "my storage bucket name"
  default     = "dtc-de-course-01152024-terra-bucket"
}

variable "gcs_storage_bucket" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}