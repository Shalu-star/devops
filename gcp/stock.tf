
resource "random_id" "bucket_prefix_stock" {
  byte_length = 8
}

resource "google_storage_bucket" "stock_bucket" {
  name                        = "${random_id.bucket_prefix_stock.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "europe-west3"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "stock_object" {
  name   = "stockupdate.zip"
  bucket = google_storage_bucket.stock_bucket.name
  source = "${path.module}/stockupdate.zip" # Add path to the zipped function source code
}


resource "google_pubsub_topic" "my_topic" {
  name = "stock-updated"
}

resource "google_cloudfunctions_function" "stock_function" {
  name        = "stock-update-function"
  description = "a new function"
  runtime     = "nodejs16"
  entry_point = "helloPubSub" # Set the entry point
  #trigger_http = false
  #trigger_topic = google_pubsub_topic.my_topic.name
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.my_topic.name
  }
  source_archive_bucket = google_storage_bucket.stock_bucket.name
  source_archive_object = google_storage_bucket_object.stock_object.name
}

resource "google_cloudfunctions_function_iam_member" "my_function_pubsub" {
  #project        = google_cloudfunctions_function.stock_function.project
  #region         = google_cloudfunctions_function.stock_function.region
  cloud_function = google_cloudfunctions_function.stock_function.name
  role        = "roles/cloudfunctions.invoker"
  member      = "allUsers"
}
/*
resource "google_cloudfunctions_trigger" "my_function_trigger" {
  service     = google_cloudfunctions_function.stock_function.service
  region      = google_cloudfunctions_function.stock_function.region
  name        = google_cloudfunctions_function.stock_function.name
  event_type  = "google.pubsub.topic.publish"
  target      = google_cloudfunctions_function.stock_function.https_trigger_url
}
*/
