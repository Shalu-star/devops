/*
resource "google_cloudfunctions_function" "example_function" {
  name        = "example-function"
  description = "Example function"
  runtime     = "java11"

  source_repository {
    url = "https://source.developers.google.com/projects/jenkins-ms/repos/github_sgupt187_terraform-demo/moveable-aliases/main/paths/my_functions/product"
  }

  trigger_http = true

  available_memory_mb = 128
  timeout             = 60
  entry_point         = "com.example.Example"

  environment_variables = {
    MY_ENV_VAR = "my-env-value"
  }
}

*/
