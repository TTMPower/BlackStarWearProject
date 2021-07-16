//
//  Network.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import Foundation
import UIKit
import Kingfisher
import SwiftyJSON

struct API {
    static var mainURL = "https://blackstarwear.ru/"
    static var catigoriesURL = "http://blackstarshop.ru/index.php?route=api/v1/categories"
    static var items = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id="
}

class Network {
    static var networkAccess = Network()
    var imageResourse = [ImageResource]()
    var imageSubResourse = [ImageResource]()
    var productData = [ProductImages]()
    var cardResourse = [ImageResource]()
    var bucketResourse = [ImageResource]()
    
    
    
    func getJsonData(url: String, complition: @escaping (ModelData) -> Void) {
        let urlMain = URL(string: url)
        var request = URLRequest(url: urlMain!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            } else if data != nil {
                do {
                    let myData = try JSONDecoder().decode(ModelData.self, from: data!)
                    complition(myData)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getJsonDataSub(url: String, complition: @escaping ([SubCategoryItems]) -> Void) {
        let urlMain = URL(string: url)
        var request = URLRequest(url: urlMain!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            } else if data != nil {
                do {
                    let jsonData = try! JSON(data: data!)
                    var myData = [SubCategoryItems]()
                    for el in jsonData {
                        myData.append(SubCategoryItems(json: el.1))
                    }
                    complition(myData)
//                    let jsonData = JSON(data!)
//                    var myData = [SubCategoryItems]()
//                    for el in jsonData {
//                        myData.append(SubCategoryItems(json: el.1))
//                    }
//                    complition(myData)
                }
            }
        }
        task.resume()
    }
    func getImage(url: String, complition: @escaping (ImageResource) -> Void) {
        let resourse = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        complition(resourse)
    }
    
}
