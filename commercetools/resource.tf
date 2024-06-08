/*resource "commercetools_zone" "example_zone" {
  key = "example-zone"
  name {
    en = "Example Zone"
  }
  locations = [
    "DE",
    "US"
  ]
}
*/

resource "commercetools_project_settings" "my-project" {
  name       = "Composable Asset"
  countries  = ["DE", "US"]
  currencies = ["EUR", "USD"]
  languages  = ["de", "en"]
  /*
  zones {
    zone_key  = "my-zone-key"
    locations = ["US", "DE"]
  }
  */
}


resource "commercetools_product_type" "my-product-type" {
  key         = "composable_asset_type"
  name        = "Composable Asset Type"
  description = "Composable Asset Type"
}


resource "commercetools_product_type" "my-product-type_main" {
  key         = "product"
  name        = "Product"
  description = "HighStreet Product Type Structure"
   
  attribute {
    name = "creationDate"
    label = {
      en = "Date of Creation"
    }
    required = false
    type {
      name = "datetime"
    }
   searchable = true
  }

  attribute {
    name = "articleNumberManufacturer"
    label = {
      en = "Manufacturer AID"
    }
    required = false
    type {
      name = "text"
    }
   searchable = true
  }

  attribute {
    name = "articleNumberMax"
    label = {
      en = "AID Maximum"
    }
    required = false
    type {
      name = "text"
    }
   searchable = true
  }

  attribute {
    name = "matrixId"
    label = {
      en = "Matrix ID"
    }
    required = false
    type {
      name = "text"
    }
   constraint = "Unique"
   searchable = true
  }

  attribute {
    name = "baseId"
    label = {
      en = "BaseID"
    }
    required = true
    type {
      name = "text"
    }
   searchable = true
  }

  attribute {
    name = "commonSize"
    label = {
      en = "FilterSize"
    }
    #set = true 
    required = false
    type {
      name = "enum"
    value {
      key   = "oneSize"
      label = "One Size"
    }
    value {
      key   = "xxs"
      label = "XXS"
    }
     value {
      key   = "xs"
      label = "XS"
    }
     value {
      key   = "s"
      label = "S"
    }
     value {
      key   = "m"
      label = "M"
    }
     value {
      key   = "l"
      label = "L"
    }
     value {
      key   = "xl"
      label = "XL"
    }
     value {
      key   = "xxl"
      label = "XXL"
    }
     value {
      key   = "xxxl"
      label = "XXXL"
    }
    }
   searchable = true
  }

attribute {
    name = "size"
    label = {
      en = "Size"
    }
    required = false
    type {
      name = "text"
    }
   searchable = true
  }

attribute {
    name = "color"
    label = {
      en = "FilterColor"
    }
    required = false
    type {
      name = "enum"
      value {
      key   = "black"
      label = "Black"
    }
      value {
      key   = "grey"
      label = "Grey"
    }
     value {
      key   = "beige"
      label = "Beige"
    }
    value {
      key   = "white"
      label = "White"
    }
    value {
      key   = "blue"
      label = "Blue"
    }
    value {
      key   = "brown"
      label = "Brown"
    }

    }
   searchable = true
  }

attribute {
    name = "colorFreeDefinition"
    label = {
      en = "Color Description"
    }
    required = false
    type {
      name = "text"
    }
   searchable = true
  }

attribute {
    name = "style"
    label = {
      en = "Style"
    }
    required = false
    type {
      name = "enum"
      value {
      key   = "business"
      label = "Business"
    }
    value {
      key   = "sporty"
      label = "Sporty"
    }
    value {
      key   = "evening"
      label = "Evening"
    }

    }
   searchable = true
  }
  
 attribute {
    name = "gender"
    label = {
      en = "Gender"
    }
    required = false
    constraint = "SameForAll"
    type {
      name = "enum"
      value {
      key   = "men"
      label = "Men"
    }
    value {
      key   = "women"
      label = "Women"
    }

    }
   searchable = true
  }

 attribute {
    name = "season"
    label = {
      en = "Season"
    }
    required = false
    constraint = "SameForAll"
    type {
      name = "text"
    }
   searchable = true
  }

 attribute {
    name = "isOnStock"
    label = {
      en = "isOnStock"
    }
    required = false
    type {
      name = "boolean"
    }
   searchable = false
  }

 attribute {
    name = "isLook"
    label = {
      en = "isLook"
    }
    required = false
    type {
      name = "boolean"
    }
   searchable = true
  }
}

