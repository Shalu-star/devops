resource "algolia_index" "Products_cmtools_index_eng_price" {
  name = "Products_cmtools_index_eng_price"
  searchable_attributes = [
      "unordered(name)",
      "unordered(categories)",
      "unordered(description)",
      "sku"
  ]

  attributes_for_faceting = [
      "searchable(categories)",
      "discount",
      "searchable(discountedPrice)",
      "price"
]


  replicas = [algolia_index.Products_cmtools_index_eng_price_asc.name, algolia_index.Products_cmtools_index_eng_price_desc.name]
}


resource "algolia_index" "Products_cmtools_index_eng_price_asc" {
  name = "Products_cmtools_index_eng_price_asc"

  searchable_attributes = [
      "unordered(name)",
      "unordered(categories)",
      "unordered(description)",
      "sku"
  ]
  
  attributes_for_faceting = [
      "searchable(categories)",
      "discount",
      "searchable(discountedPrice)",
      "price"
]


 

  ranking = [
      "asc(price)",
      "typo",
      "geo",
      "words",
      "filters",
      "proximity",
      "attribute",
      "exact",
      "custom"
  ]
  
}

resource "algolia_index" "Products_cmtools_index_eng_price_desc" {
  name = "Products_cmtools_index_eng_price_desc"

  searchable_attributes = [
      "unordered(name)",
      "unordered(categories)",
      "unordered(description)",
      "sku"
  ]

  attributes_for_faceting = [
      "searchable(categories)",
      "discount",
      "searchable(discountedPrice)",
      "price"
]


  ranking = [
      "desc(price)",
      "typo",
      "geo",
      "words",
      "filters",
      "proximity",
      "attribute",
      "exact",
      "custom"
  ]
}
