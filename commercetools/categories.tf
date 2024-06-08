resource "commercetools_category" "shoes-category" {
  key = "c1"
  name = {
    en = "Shoes"
  }
  external_id = 1
  slug = {
    en = "shoes_category"
  }
}

resource "commercetools_category" "men-category" {
  name = {
   en = "Men"
}
  slug = {
    en = "men-category"
}
parent    = commercetools_category.shoes-category.id
}

resource "commercetools_category" "women-category" {
  name = {
   en = "Women"
}
  slug = {
    en = "women-category"
}
parent    = commercetools_category.shoes-category.id
}


resource "commercetools_category" "bags-category" {
  key = "c2"
  name = {
    en = "Bags"
  }
  external_id = 2
  slug = {
    en = "bags_category"
  }
}

resource "commercetools_category" "handbags-category" {
  name = {
   en = "Hand Bags"
}
  slug = {
    en = "handbags-category"
}
parent    = commercetools_category.bags-category.id
}

resource "commercetools_category" "womenbags-category" {
  name = {
   en = "Women Bags"
}
  slug = {
    en = "womenbags-category"
}
parent    = commercetools_category.bags-category.id
}

resource "commercetools_category" "travelbags-category" {
  name = {
   en = "Travel Bags"
}
  slug = {
    en = "travelbags-category"
}
parent    = commercetools_category.bags-category.id
}

resource "commercetools_category" "perfumes-category" {
  key = "c3"
  name = {
    en = "Perfumes"
  }
  external_id = 3
  slug = {
    en = "perfumes_category"
  }
}

resource "commercetools_category" "womens-category" {
  name = {
   en = "Women's"
}
  slug = {
    en = "womens-category"
}
parent    = commercetools_category.perfumes-category.id
}

resource "commercetools_category" "womens-special-occasion-category" {
  name = {
   en = "Special Occasion"
}
  slug = {
    en = "womens-special-occasion-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "womens-gift-pack-category" {
  name = {
   en = "Gift Pack"
}
  slug = {
    en = "womens-gift-pack-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "womens-latest-category" {
  name = {
   en = "Latest"
}
  slug = {
    en = "womens-latest-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "womens-natural-category" {
  name = {
   en = "Natural"
}
  slug = {
    en = "womens-natural-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "womens-dryperfumes-category" {
  name = {
   en = "Dry Perfumes"
}
  slug = {
    en = "womens-dryperfumes-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "mens-fruity-category" {
  name = {
   en = "Fruity"
}
  slug = {
    en = "womens-fruity-category"
}
parent    = commercetools_category.womens-category.id
}

resource "commercetools_category" "mens-category" {
  name = {
   en = "Men's"
}
  slug = {
    en = "mens-category"
}
parent    = commercetools_category.perfumes-category.id
}

resource "commercetools_category" "mens-special-occasion-category" {
  name = {
   en = "Special Occasion"
}
  slug = {
    en = "men-special-occasion-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "mens-gift-pack-category" {
  name = {
   en = "Gift Pack"
}
  slug = {
    en = "men-gift-pack-category"
}
parent    = commercetools_category.mens-category.id
}


resource "commercetools_category" "mens-woody-category" {
  name = {
   en = "Woody"
}
  slug = {
    en = "men-woody-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "mens-latest-category" {
  name = {
   en = "Latest"
}
  slug = {
    en = "men-latest-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "mens-natural-category" {
  name = {
   en = "Natural"
}
  slug = {
    en = "men-natural-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "mens-dryperfumes-category" {
  name = {
   en = "Dry Perfumes"
}
  slug = {
    en = "men-dryperfumes-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "mens-moistperfumes-category" {
  name = {
   en = "Moist Perfumes"
}
  slug = {
    en = "men-moistperfumes-category"
}
parent    = commercetools_category.mens-category.id
}

resource "commercetools_category" "clothes-category" {
  key = "c4"
  name = {
    en = "Clothes"
  }
  external_id = 4
  slug = {
    en = "clothes_category"
  }
}

resource "commercetools_category" "tshirts-category" {
  name = {
   en = "T-Shirts"
}
  slug = {
    en = "tshirts-category-category"
}
parent    = commercetools_category.clothes-category.id
}

resource "commercetools_category" "partywear-category" {
  name = {
   en = "Party Wear"
}
  slug = {
    en = "partywear-category"
}
parent    = commercetools_category.clothes-category.id
}

resource "commercetools_category" "accessories-category" {
  key = "c5"
  name = {
    en = "Accessories"
  }
  external_id = 5
  slug = {
    en = "accessories-category"
  }
}

resource "commercetools_category" "bracelets-category" {
  name = {
   en = "Bracelets"
}
  slug = {
    en = "bracelets-category"
}
parent    = commercetools_category.accessories-category.id
}

resource "commercetools_category" "wallets-category" {
  name = {
   en = "Wallets"
}
  slug = {
    en = "wallets-category"
}
parent    = commercetools_category.accessories-category.id
}

resource "commercetools_category" "sunglass-category" {
  name = {
   en = "Sun Glasses"
}
  slug = {
    en = "sunglass-category"
}
parent    = commercetools_category.accessories-category.id
}

