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
    static var catigoriesURL = "HIDE TOKEN"
    static var items = "HIDE TOKEN"
}

class Network {
    static var networkAccess = Network()
    var imageResourse = [ImageResource]()
    var imageSubResourse = [ImageResource]()
    var productData = [ProductImages]()
    var cardResourse = [ImageResource]()
    var bucketResourse = [ImageResource]()
    var placeHolder: ImageResource? = nil
    
    func fromDoubleToString(double: String) -> String {
        var priceOut = String()
        if let integer = Double(double) {
            let price = "\(String(format: "%.0f", integer)) руб."
            priceOut = price
        }
        return priceOut
    }
    
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
                    let filtredData = myData.filter({$0.value.name != "Последний размер"}).filter({$0.value.name != "Все товары категории"}).filter({$0.value.name != "Предзаказ"}).filter({$0.value.name != "Marketplace"}).filter({$0.value.name != "Коллекции"}).filter({$0.value.name != "Сезонный BOOM"})
                    complition(filtredData)
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
                    let filterData = myData.sorted {
                        var isSorted = false
                        if let first = $0.name, let second = $1.name {
                            isSorted = first < second
                        }
                        return isSorted
                    }
                    complition(filterData)
                }
            }
        }
        task.resume()
    }
    func getImage(url: String, complition: @escaping (ImageResource) -> Void) {
        if let urls = URL(string: url) {
        let resourse = ImageResource(downloadURL: urls, cacheKey: url)
        complition(resourse)
        }
    }
    
}
