resource "commercetools_store" "my-store1" {
  key = "highstreet-de"
  name = {
    en = "Highstreet DE"
  }
  #countries             = ["DE"]
  languages             = ["de"]
  distribution_channels = ["POS-HS-DE1"]
  supply_channels       = ["POS-HS-DE1","WH-HS-DE1"]
/*
  custom {
    type_id = commercetools_type.my-store-type.id
    fields = {
      my-field = "ja"
    }
  }
*/
  depends_on = [
    commercetools_channel.my-channel1,
    commercetools_channel.my-channel2,
  ]
}



resource "commercetools_store" "my-store2" {
  key = "highstreet-us"
  name = {
    en = "Highstreet US"
  }
  #countries             = ["US"]
  languages             = ["en"]
  distribution_channels = ["POS-HS-US1"]
  supply_channels       = ["POS-HS-US1","WH-HS-US1"]
  depends_on = [
    commercetools_channel.my-channel4,
    commercetools_channel.my-channel3,
  ]
}
