/*

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "bucket" {
  name                        = "${random_id.bucket_prefix.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "us-west3"
  uniform_bucket_level_access = true
  force_destroy = true
}

resource "google_storage_bucket_object" "object" {
  name   = "product.zip"
  bucket = google_storage_bucket.bucket.name
  #source = "${path.module}/product.zip" # Add path to the zipped function source code
  source = "${path.module}/product.zip"

}

resource "google_cloudfunctions_function" "function" {
  name        = "product-sync"
  description = "a new function"

 
  runtime     = "java11"
  entry_point = "com.example.Example" # Set the entry point
  trigger_http = true   
    source_archive_bucket = google_storage_bucket.bucket.name
    source_archive_object = google_storage_bucket_object.object.name
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invokerfun" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}


*/
