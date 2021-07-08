struct SubCategoryItems: Codable {
    var name: String?
    var englishName: String?
    var sortOrder: Int?
    var article: String?
    var description: String?
    var colorName: String?
    var colorImageURL: String?
    var mainImage: String?
    var productImages: [ProductImages]?
    var offers: [Offers]?
    var recommendedProductIDs: [String]?
    var instagramPhotos: [String]?
    var price: String?
    var oldPrice: String?
    var tag: String?
    var attributes: [Attributes]
}

struct ProductImages: Codable {
    var imageURL: String?
    var sortOrder: String?
}

struct Offers: Codable {
    var size: String?
    var productOfferID: String?
    var quantity: String?
}

struct Attributes: Codable {
    var decorativeElement: String?
    var image: String?
    var sezone: String?
    var sostav: String?
    var madein: String?
    var uhod: String?
}

//{
//    "5911_331": {
//        "name": "Худи CREATED",
//        "englishName": "CREATED hoodie",
//        "sortOrder": "57",
//        "article": "MA0218-060",
//        "collection": null,
//        "description": "Создайте свой уникальный лук с помощью худи CREATED из коллекции Black Star Wear. Каждая деталь модели подчеркивает ее особый стиль – цвет хаки, принт с надписью на груди, капюшон в красную клетку. При этом дизайну изделия присущи традиционные линии, которые делают его удобным и практичным предметом повседневного гардероба. В передней части оформлен накладной карман-трапеция, на рукаве имеется нашивка с цифрами 777. Худи изготовлено из дорогого хлопкового полотна с примесью эластана, в разы увеличивающего практичные свойства ткани. Подберите к нему брюки CREATED из коллекции Black Star Wear и получите стильный комплект одежды.",
//        "colorName": "Хаки",
//        "colorImageURL": "image/catalog/style/color/khaki_c3b091.jpg",
//        "mainImage": "image/cache/catalog/p/5911/doro6552-h_1_630x840.jpg",
//        "productImages": [
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6550-h_1_630x840.jpg",
//                "sortOrder": "1"
//            },
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6553-h_1_630x840.jpg",
//                "sortOrder": "2"
//            },
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6554-h_1_630x840.jpg",
//                "sortOrder": "3"
//            },
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6557-h_1_630x840.jpg",
//                "sortOrder": "4"
//            },
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6558-h_1_630x840.jpg",
//                "sortOrder": "5"
//            },
//            {
//                "imageURL": "image/cache/catalog/p/5911/doro6559-h_1_630x840.jpg",
//                "sortOrder": "6"
//            }
//        ],
//        "offers": [
//            {
//                "size": "XS",
//                "productOfferID": "30454",
//                "quantity": "1"
//            }
//        ],
//        "recommendedProductIDs": [
//            "6236_282",
//            "7992_219",
//            "7641_219",
//            "7637_219",
//            "8120_37978",
//            "7994_219"
//        ],
//        "instagramPhotos": [],
//        "price": "2500.0000",
//        "oldPrice": "5900.0000",
//        "tag": "-60%",
//        "attributes": [
//            {
//                "Декоративный элемент": "принт"
//            },
//            {
//                "Рисунок": " надпись"
//            },
//            {
//                "Сезон": "круглогодичный"
//            },
//            {
//                "Состав": "80% хлопок; 20% эластан"
//            },
//            {
//                "Страна производителя": "Россия"
//            },
//            {
//                "Уход за вещами": "бережная стирка при 30 градусах"
//            }
//        ]
//    }
//}
