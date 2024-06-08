resource "commercetools_channel" "my-channel1" {
  key   = "POS-HS-DE1"
  roles = ["ProductDistribution","InventorySupply"]
  name = {
    en = "Highstreet DE POS 1"
  }
  description = {
    en = "Highstreet DE POS 1"
  }
}

resource "commercetools_channel" "my-channel2" {
  key   = "WH-HS-DE1"
  roles = ["InventorySupply"]
  name = {
    en = "Highstreet DE Warehouse 1"
  }
  description = {
    en = "Highstreet DE Warehouse 1"
  }
}

resource "commercetools_channel" "my-channel3" {
  key   = "WH-HS-US1"
  roles = ["InventorySupply"]
  name = {
    en = "Highstreet US Warehouse 1"
  }
  description = {
    en = "Highstreet US Warehouse 1"
  }
}

resource "commercetools_channel" "my-channel4" {
  key   = "POS-HS-US1"
  roles = ["InventorySupply","ProductDistribution"]
  name = {
    en = "Highstreet US POS 1"
  }
  description = {
    en = "Highstreet US POS 1"
  }
}
