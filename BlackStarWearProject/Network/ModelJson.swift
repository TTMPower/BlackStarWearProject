// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelData = try? newJSONDecoder().decode(ModelData.self, from: jsonData)

import Foundation

// MARK: - ModelDataValue
struct ModelDataValue: Codable {
    var name: String?
    var image: String?
    var iconImage: String?
    var iconImageActive: String?
    var subcategories: [Subcategory]?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image = "image"
        case iconImage = "iconImage"
        case iconImageActive = "iconImageActive"
        case subcategories = "subcategories"
    }
}

// MARK: - Subcategory
struct Subcategory: Codable {
    var iconImage: String?
    var name: String?
    var type: TypeEnum?

    enum CodingKeys: String, CodingKey {
        case iconImage = "iconImage"
        case name = "name"
        case type = "type"
    }
}

enum TypeEnum: String, Codable {
    case category = "Category"
    case collection = "Collection"
}

typealias ModelData = [String: ModelDataValue]
