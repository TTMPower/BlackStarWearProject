//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let modelData = try? newJSONDecoder().decode(ModelData.self, from: jsonData)
//import Foundation
//
//// MARK: - ModelDataValue
//struct ModelDataValue: Codable {
//    var name: String?
//    var image: String?
//    var iconImage: String?
//    var iconImageActive: String?
//    var subcategories: [Subcategory]
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case image = "image"
//        case iconImage = "iconImage"
//        case iconImageActive = "iconImageActive"
//        case subcategories = "subcategories"
//    }
//}
//
//// MARK: - Subcategory
//struct Subcategory: Codable {
//    var iconImage: String?
//    var name: String?
//    var type: TypeEnum?
//
//    enum CodingKeys: String, CodingKey {
//        case iconImage = "iconImage"
//        case name = "name"
//        case type = "type"
//    }
//}
//
//enum TypeEnum: String, Codable {
//    case category = "Category"
//    case collection = "Collection"
//}
//
//typealias ModelData = [String: ModelDataValue]

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelData = try? newJSONDecoder().decode(ModelData.self, from: jsonData)

import Foundation

struct ModelDataValue: Codable {
    var name: String?
    var sortOrder: SortOrder?
    var image: String?
    var iconImage: String?
    var iconImageActive: String?
    var subcategories: [Subcategory]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sortOrder = "sortOrder"
        case image = "image"
        case iconImage = "iconImage"
        case iconImageActive = "iconImageActive"
        case subcategories = "subcategories"
    }
}

enum SortOrder: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .string(container.decode(String.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .integer(container.decode(Int.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(SortOrder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}

// MARK: - Subcategory
struct Subcategory: Codable {
    var id: SortOrder?
    var iconImage: String?
    var sortOrder: SortOrder?
    var name: String?
    var type: TypeEnum?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iconImage = "iconImage"
        case sortOrder = "sortOrder"
        case name = "name"
        case type = "type"
    }
}

enum TypeEnum: String, Codable {
    case category = "Category"
    case collection = "Collection"
}

typealias ModelData = [String: ModelDataValue]
