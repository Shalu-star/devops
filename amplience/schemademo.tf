resource "amplience_content_type_schema" "page_link" {
  #body             = file("${path.module}/content-type-schemas/schemas/page-link-schema.json")
  body             = file("${path.module}/page-link-schema.json")
  schema_id        = "https://tf-amplience-provider.com/page_link"
  validation_level = "CONTENT_TYPE"
}
