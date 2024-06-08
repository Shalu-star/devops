locals {
  project = "composable-commerce123"
  region  = "europe-west1"
}
resource "google_pubsub_topic" "resource-updates" {
  name = "resource-updates"
}

# add ctp subscription service account
resource "google_pubsub_topic_iam_member" "ctp-subscription-publisher" {
  topic  = google_pubsub_topic.resource-updates.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:subscriptions@commercetools-platform.iam.gserviceaccount.com"
}

resource "commercetools_subscription" "subscribe" {
  key = "my-subscription"

  destination {
    type        = "GoogleCloudPubSub"
    project_id  = "jenkins-ms"
    topic       = google_pubsub_topic.resource-updates.name
  }

  changes {
    resource_type_ids = [
      "category",
      "product",
      "product-type",
      "customer-group"
    ]
  }

 depends_on = [
    "google_pubsub_topic_iam_member.ctp-subscription-publisher"
  ]
}


