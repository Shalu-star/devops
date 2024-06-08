resource "commercetools_product_discount" "my-product-discount" {
  key = "PSALE5"
  name = {
    en = "Product Sale"
  }
  description = {
    en = "Product Sale"
  }
  predicate   = "1=1"
  sort_order  = "0.9"
  is_active   = true
  #valid_from  = "2023-02-26T00:00:00.000Z"
  valid_until = "2023-07-17T15:04:05.000Z"
  valid_from   = "2019-01-01T00:00:00.000Z"
  #valid_until  = "2022-02-26T15:04:05.000Z"
  value {
    type      = "relative"
    permyriad = 500
  }
}
