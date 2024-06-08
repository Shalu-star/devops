locals {
  project = "terraformtrial"
  region  = "us-central1"
}
/*
resource "google_pubsub_topic" "my_topic1" {
  name = "algoliadeltaindexingtopicdemo"
}

# add ctp subscription service account
resource "google_pubsub_topic_iam_member" "ctp-subscription-publisher1" {
  topic  = google_pubsub_topic.my_topic1.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:subscriptions@commercetools-platform.iam.gserviceaccount.com"
}

resource "commercetools_subscription" "my-subscription1" {
 
  destination {
    type        = "GoogleCloudPubSub"
    project_id  = "jenkins-ms"
    topic       = google_pubsub_topic.my_topic1.name
  }
  
  message {
    resource_type_id = "product"
	types = ["ProductPublished","ProductUnpublished"]
  }

 depends_on = [
    "google_pubsub_topic_iam_member.ctp-subscription-publisher1"
  ]
}



resource "google_pubsub_topic" "my_topic2" {
  name = "commercetools-create-order-demo"
}

# add ctp subscription service account
resource "google_pubsub_topic_iam_member" "ctp-subscription-publisher2" {
  topic  = google_pubsub_topic.my_topic2.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:subscriptions@commercetools-platform.iam.gserviceaccount.com"
}

resource "commercetools_subscription" "my-subscription2" {
  key = "create-order-queue"

  destination {
    type        = "GoogleCloudPubSub"
    project_id  = "jenkins-ms"
    topic       = google_pubsub_topic.my_topic2.name
  }

  message {
    resource_type_id = "order"
        types = []
  }

 depends_on = [
    "google_pubsub_topic_iam_member.ctp-subscription-publisher2"
  ]
}

*/



resource "commercetools_subscription" "my-subscription" {
  key = "test-queue-order-new"

  destination {
    type        = "GoogleCloudPubSub"
    project_id  = "jenkins-ms"
    topic       = "commercetools-create-order"
  }

  message {
    resource_type_id = "order"
        types = []
  }
}


