
resource "random_id" "bucket_prefix_order" {
  byte_length = 8
}

resource "google_storage_bucket" "order_bucket" {
  name                        = "${random_id.bucket_prefix_order.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "europe-west3"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "order_object" {
  name   = "mb_send_order.zip"
  bucket = google_storage_bucket.order_bucket.name
  source = "${path.module}/mb_send_order.zip" # Add path to the zipped function source code
}


resource "google_pubsub_topic" "my_order_topic" {
  name = "order-placed"
}

resource "google_pubsub_topic_iam_binding" "order_binding" {
  topic       = google_pubsub_topic.my_order_topic.name
  role        = "roles/pubsub.publisher"
  members     = ["serviceAccount:${google_cloudfunctions_function.order_function.service_account_email}"]
}

resource "google_cloudfunctions_function" "order_function" {
  name        = "mb-send-order-function"
  description = "a new function"
  region      = "europe-west3"
  runtime     = "nodejs16"
  entry_point = "helloPubSub" # Set the entry point
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.my_order_topic.name
  }
  source_archive_bucket = google_storage_bucket.order_bucket.name
  source_archive_object = google_storage_bucket_object.order_object.name
}

