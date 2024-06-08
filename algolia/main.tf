terraform {
    required_version = ">=1.4.4"

    required_providers {
        algolia = {
            source  = "philippe-vandermoere/algolia"
        }
    }
}

provider "algolia" {
  api_key = "09d92dfd1e9669b1d8e5ee86653e7a3f"
  application_id = "VHXT4I8OD8"
}
/*
resource "algolia_index" "example1" {
  name = "example1"
 
  #min_word_size_for_1_typo = 4
  #min_word_size_for_2_typos = 8
  hits_per_page = 10
  max_values_per_facet = 100
  searchable_attributes = [
      "unordered(name)",
      "unordered(categories)",
      "unordered(description)",
      "sku"
  ]
  #numeric_attributes_to_index = null
  attributes_to_retrieve = null
  unretrievable_attributes = null
  #optional_words = null
  attributes_for_faceting = [
      "searchable(categories)",
      "discount",
      "searchable(discountedPrice)",
      "price"
  ]
  #attributes_to_snippet = null
  #attributes_to_highlight = null
  pagination_limited_to = 1000
  attribute_for_distinct = null
  #exact_on_single_word_query = "attribute"
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
  custom_ranking = null
}
*/
