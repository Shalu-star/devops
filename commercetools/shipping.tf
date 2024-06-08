resource "commercetools_shipping_zone" "us" {
  name        = "US"
  location {
    country = "US"
  }
}

resource "commercetools_shipping_zone" "de" {
  name        = "DE"
  location {
    country = "DE"
  }
}


resource "commercetools_shipping_method" "my-shipping-method1" {
  name            = "EXPRESS"
  description     = "EXPRESS"
  is_default      = false
  tax_category_id = commercetools_tax_category.my-tax-category.id
}

resource "commercetools_shipping_zone_rate" "my-shipping-zone-rate1" {
  shipping_method_id = commercetools_shipping_method.my-shipping-method1.id
  shipping_zone_id   = commercetools_shipping_zone.us.id

  price {
    cent_amount   = 600
    currency_code = "USD"
  }
}

resource "commercetools_shipping_method" "my-shipping-method2" {
  name            = "STANDARD"
  is_default      = true
  tax_category_id = commercetools_tax_category.my-tax-category.id
}

resource "commercetools_shipping_zone_rate" "my-shipping-zone-rate2" {
  shipping_method_id = commercetools_shipping_method.my-shipping-method2.id
  shipping_zone_id   = commercetools_shipping_zone.us.id

  price {
    cent_amount = 0
    currency_code = "USD"
  }
}
