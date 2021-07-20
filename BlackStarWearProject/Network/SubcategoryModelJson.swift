import SwiftyJSON

typealias ItemsData = [String: SubCategoryItems]

class SubCategoryItems: Codable {
    var name: String?
    var englishName: String?
    var sortOrder: Int?
    var article: String?
    var colorName: String?
    var description1: String?
    var colorImageURL: String?
    var mainImage: String?
    var productImages: [ProductImages]?
    var offers: [Offers]?
    var recommendedProductIDs: [String]?
    var instagramPhotos: [String]?
    var price: String?
    var oldPrice: String?
    var tag: String?
    var attributes: [Attributes]?
    
    init(json: JSON) {
        
        self.productImages = [ProductImages]()
        let productImagesArray = json["productImages"].arrayValue
        for images in productImagesArray {
            let value = ProductImages(json: images)
            productImages?.append(value)
        }
        attributes = [Attributes]()
        let attributesArray = json["attributes"].arrayValue
        for el in attributesArray {
            if el.isEmpty {
                print("Error")
            } else {
            let value = Attributes(json: el)
            attributes?.append(value)
        }
        }
        self.offers = [Offers]()
        let offersArray = json["offers"].arrayValue
        for i in offersArray {
            let value = Offers(json: i)
            offers?.append(value)
        }
        
        self.name = json["name"].stringValue
        self.englishName = json["englishName"].stringValue
        self.sortOrder = json["sortOrder"].intValue
        self.article = json["article"].stringValue
        self.description1 = json["description"].stringValue
        self.colorName = json["colorName"].stringValue
        self.colorImageURL = json["colorImageURL"].stringValue
        self.mainImage = json["mainImage"].stringValue
        self.recommendedProductIDs = json["recommendedProductIDs"].arrayValue.map({ $0.stringValue })
        self.instagramPhotos = json["instagramPhotos"].arrayValue.map({ $0.stringValue })
        self.price = json["price"].stringValue
        self.oldPrice = json["oldPrice"].stringValue
        self.tag = json["tag"].stringValue
    }
}

class ProductImages: Codable {
    var imageURL: String?
    var sortOrder: String?
    
    init(json: JSON){
        self.imageURL = json["imageURL"].stringValue
        self.sortOrder = json["sortOrder"].stringValue
    }
}

class Offers: Codable {
    var size: String?
    var productOfferID: String?
    var quantity: String?
    
    init(json: JSON){
        self.size = json["size"].stringValue
        self.productOfferID = json["productOfferID"].stringValue
        self.quantity = json["quantity"].stringValue
    }
}

class Attributes: Codable {
    var decorativeElement: String?
    var image: String?
    var sezone: String?
    var sostav: String?
    var madein: String?
    var uhod: String?
    var size: String?
    
    init(json: JSON){
        self.decorativeElement = json["Декоративный элемент"].stringValue
        self.image = json["Рисунок"].stringValue
        self.sezone = json["Сезон"].stringValue
        self.sostav = json["Состав"].stringValue
        self.madein = json["Страна производителя"].stringValue
        self.uhod = json["Уход за вещами"].stringValue
        self.size = json["Размер на модели"].stringValue
    }
    
}
