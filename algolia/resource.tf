/*resource "algolia_index" "example2" {
  name = "example2"

  
  settings =  {
    "minWordSizefor1Typo": 4
    "minWordSizefor2Typos": 8
    "hitsPerPage": 10
    "maxValuesPerFacet": 100
    "searchableAttributes": [
      "unordered(name)",
      "unordered(categories)",
      "unordered(description)",
      "sku"
    ]
    "numericAttributesToIndex": null
    "attributesToRetrieve": null
    "unretrievableAttributes": null
    "optionalWords": null
    "attributesForFaceting": [
      "searchable(categories)",
      "discount",
      "searchable(discountedPrice)",
      "price"
    ]
    "attributesToSnippet": null
    "attributesToHighlight": null
    "paginationLimitedTo": 1000
    "attributeForDistinct": null
    "exactOnSingleWordQuery": "attribute"
    "ranking": [
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
    "customRanking": null
    "separatorsToIndex": ""
    "removeWordsIfNoResults": "none"
    "queryType": "prefixLast"
    "highlightPreTag": "<em>"
    "highlightPostTag": "</em>"
    "alternativesAsExact": [
      "ignorePlurals",
      "singleWordSynonym"
    ]
    "renderingContent": {
      "facetOrdering": {
        "facets": {
          "order": [
            "categories",
            "discount"
          ]
        }
        "values": {
          "categories": {
            "order": [
              "Women",
              "Men",
              "Women Bags",
              "Hand Bags",
              "Travel Bags",
              "Dry Perfumes",
              "Moist Perfumes",
              "Special Occasion",
              "Party Wear",
              "T-shirts",
              "Wallets"
            ]
            "sortRemainingBy": "hidden"
          }
        }
      }
    }
  }
  rules = [
    {
      "_metadata": {
        "lastUpdate": 1679635030
      },
      "enabled": false,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "contains",
          "pattern": "Clothes",
          "alternatives": true
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "38d5eb17-9cef-4903-85df-744a166c1cce"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "2aa5a03e-0487-4484-b758-4dc3998bc0da"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "7ee5c0d2-509a-4e0a-a370-635d9c904a2e"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1677595387911"
    },
    {
      "_metadata": {
        "lastUpdate": 1679635030
      },
      "enabled": false,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "contains",
          "pattern": "Bags",
          "alternatives": true
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "33379186-7776-4387-adb8-f5470d9f815f"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "050497de-3cfa-433a-82d1-afd46023c70e"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "9465f1b1-3053-41d0-a015-5d69eb6409f7"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      }
      "objectID": "qr-1677595307514"
    },
    {
      "_metadata": {
        "lastUpdate": 1679635030
      },
      "enabled": false,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "contains",
          "pattern": "Perfumes",
          "alternatives": true
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "4e4b44f5-6a63-4721-9e74-b24d35d2322e"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "1505291a-c6b0-466d-94ec-668c415682ce"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "890f1e49-1d2d-48cc-b4e7-a3fe62b5434e"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1677594787588"
    },
    {
      "_metadata": {
        "lastUpdate": 1679635030
      },
      "enabled": false,
      "tags": [
        "visual-editor"
      ],
      "description": "Promoted discounted shoes",
      "conditions": [
        {
          "anchoring": "contains",
          "pattern": "shoes",
          "alternatives": true
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "82e5d89e-6bb1-4ec4-9010-9f62dad1f889"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "69758384-b1ef-4a93-8128-f50fa280a069"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "9445c008-0107-4250-8a5d-88bd48d14ca7"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1677593836179"
    },
    {
      "_metadata": {
        "lastUpdate": 1679311010
      },
      "enabled": true,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "is",
          "pattern": "",
          "alternatives": false,
          "filters": "(\"categories\":\"Clothes\")"
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "38d5eb17-9cef-4903-85df-744a166c1cce"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "2aa5a03e-0487-4484-b758-4dc3998bc0da"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "7ee5c0d2-509a-4e0a-a370-635d9c904a2e"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1679310950206"
    },
    {
      "_metadata": {
        "lastUpdate": 1679310922
      },
      "enabled": true,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "is",
          "pattern": "",
          "alternatives": false,
          "filters": "(\"categories\":\"Perfumes\")"
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "1505291a-c6b0-466d-94ec-668c415682ce"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "890f1e49-1d2d-48cc-b4e7-a3fe62b5434e"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "4e4b44f5-6a63-4721-9e74-b24d35d2322e"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1679310843614"
    },
    {
      "_metadata": {
        "lastUpdate": 1679310801
      },
      "enabled": true,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "is",
          "pattern": "",
          "alternatives": false,
          "filters": "(\"categories\":\"Bags\")"
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "33379186-7776-4387-adb8-f5470d9f815f"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "050497de-3cfa-433a-82d1-afd46023c70e"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "9465f1b1-3053-41d0-a015-5d69eb6409f7"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1679310713614"
    },
    {
      "_metadata": {
        "lastUpdate": 1679310683
      },
      "enabled": true,
      "tags": [
        "visual-editor"
      ],
      "conditions": [
        {
          "anchoring": "is",
          "pattern": "",
          "alternatives": false,
          "filters": "(\"categories\":\"Shoes\")"
        }
      ],
      "consequence": {
        "promote": [
          {
            "objectIDs": [
              "82e5d89e-6bb1-4ec4-9010-9f62dad1f889"
            ],
            "position": 0
          },
          {
            "objectIDs": [
              "69758384-b1ef-4a93-8128-f50fa280a069"
            ],
            "position": 1
          },
          {
            "objectIDs": [
              "9445c008-0107-4250-8a5d-88bd48d14ca7"
            ],
            "position": 2
          }
        ],
        "filterPromotes": true
      },
      "objectID": "qr-1679310427089"
    }
  ]

  synonyms = []


}

*/
