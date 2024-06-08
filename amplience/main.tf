terraform {
  required_providers {
    amplience = {
      source = "labd/amplience"
    }
  }
}

provider "amplience" {
  client_id     = "d60acc03-42cd-4a0b-8fe9-8d6f9b6004be"
  client_secret = "0da2fa971b2bb42b8c6b66e4eee201017a2de91a8568b33efeef93938d6f5758"
  hub_id = "61e59e27cff47e0001bf340b"
}
