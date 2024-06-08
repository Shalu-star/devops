resource "commercetools_type" "my-custom-type" {
  key = "ct-store-custom"
  name = {
    en = "storeCustomFields"
  }
  description = {
    en = "storeCustomFields"
  }
  resource_type_ids = ["store"]
  #field_definitions = [
    field {
     type {
       name = "Boolean"
     }
     name = "stockCheckEnabled"
     label = {
       en = "stockCheckEnabled"
     }
     required = false
    }
    field {
     type {
       name = "Number"
     }
     name = "lowStockThreshold"
     label = {
       en = "lowStockThreshold"
     }
     required = false

    }
     
  #]
  
}
