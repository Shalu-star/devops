/*
resource "google_cloudfunctions_function" "my_algolia_function" {
  name        = "algoliasearchfunc"
  description = "My function description."
  runtime     = "java11"
  entry_point = "com.example.Example"
  trigger_http = true

  source_repository {
    url = "https://source.developers.google.com/projects/jenkins-ms/repos/github_sgupt187_terraform-demo/moveable-aliases/main/paths/my_functions/algoliasearchfunc"
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker1" {
  project        = google_cloudfunctions_function.my_algolia_function.project
  region         = google_cloudfunctions_function.my_algolia_function.region
  cloud_function = google_cloudfunctions_function.my_algolia_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}



*/
