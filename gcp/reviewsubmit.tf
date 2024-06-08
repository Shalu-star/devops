
resource "random_id" "bucket_prefix_review" {
  byte_length = 8
}

resource "google_storage_bucket" "review_bucket" {
  name                        = "${random_id.bucket_prefix_review.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "europe-west3"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "review_object" {
  name   = "mb_send_review.zip"
  bucket = google_storage_bucket.review_bucket.name
  source = "${path.module}/mb_send_review.zip" # Add path to the zipped function source code
}


resource "google_pubsub_topic" "my_review_topic" {
  name = "submit-review"
}

resource "google_pubsub_topic_iam_binding" "review_binding" {
  topic       = google_pubsub_topic.my_review_topic.name
  role        = "roles/pubsub.publisher"
  members     = ["serviceAccount:${google_cloudfunctions_function.review_function.service_account_email}"]
}

resource "google_cloudfunctions_function" "review_function" {
  name        = "mb-send-review-function"
  description = "a new function"
  region      = "europe-west3"
  runtime     = "java17"
  entry_point = "com.example.Example" # Set the entry point
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.my_review_topic.name
  }
  source_archive_bucket = google_storage_bucket.review_bucket.name
  source_archive_object = google_storage_bucket_object.review_object.name
}

