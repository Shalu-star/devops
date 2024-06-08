
resource "random_id" "bucket_prefix_price" {
  byte_length = 8
}

resource "google_storage_bucket" "price_bucket" {
  name                        = "${random_id.bucket_prefix_price.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "europe-west3"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "price_object" {
  name   = "priceupdate.zip"
  bucket = google_storage_bucket.price_bucket.name
  source = "${path.module}/priceupdate.zip" # Add path to the zipped function source code
}


resource "google_pubsub_topic" "my_price_topic" {
  name = "price-updated"
}

resource "google_pubsub_topic_iam_binding" "example" {
  topic       = google_pubsub_topic.my_price_topic.name
  role        = "roles/pubsub.publisher"
  members     = ["serviceAccount:${google_cloudfunctions_function.price_function.service_account_email}"]
}

resource "google_cloudfunctions_function" "price_function" {
  name        = "price-update-function"
  description = "a new function"
  region      = "europe-west3"
  runtime     = "nodejs16"
  entry_point = "helloPubSub" # Set the entry point
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.my_price_topic.name
  }
  source_archive_bucket = google_storage_bucket.price_bucket.name
  source_archive_object = google_storage_bucket_object.price_object.name
}

