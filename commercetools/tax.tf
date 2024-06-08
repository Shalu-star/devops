resource "commercetools_tax_category" "my-tax-category" {
  key         = "standard"
  name        = "standard"
}

resource "commercetools_tax_category_rate" "standard-tax-category-DE" {
  tax_category_id   = commercetools_tax_category.my-tax-category.id
  name              = "10% incl"
  amount            = 0.1
  included_in_price = false
  country           = "DE"
}

resource "commercetools_tax_category_rate" "standard-tax-category-US" {
  tax_category_id   = commercetools_tax_category.my-tax-category.id
  name              = "10% incl"
  amount            = 0.1
  included_in_price = false
  country           = "US"
}

