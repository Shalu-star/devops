
resource "google_storage_bucket" "my_bucket" {
  name          = "my-composable-bucket"
  location      = "us-central1"
  storage_class = "STANDARD"
}

resource "google_storage_bucket_object" "my_function_code" {
  name   = "algoliasearchfunc_function-source.zip"
  bucket = google_storage_bucket.my_bucket.name
  source = "${path.module}/algoliasearchfunc_function-source.zip"
}

resource "google_cloudfunctions_function" "my_function" {
  name        = "algoliasearchfunc"
  description = "My function description."
  runtime     = "java11"
  entry_point = "com.example.Example"
  trigger_http = true

  source_archive_bucket = google_storage_bucket.my_bucket.name
  source_archive_object = google_storage_bucket_object.my_function_code.name
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.my_function.project
  region         = google_cloudfunctions_function.my_function.region
  cloud_function = google_cloudfunctions_function.my_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}


