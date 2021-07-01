//
//  Network.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import Foundation
import UIKit
import Kingfisher

struct API {
    static var mainURL = "https://blackstarwear.ru/"
    static var catigoriesURL = "http://blackstarshop.ru/index.php?route=api/v1/categories"
}

class Network {
    static var networkAccess = Network()
    var imageResourse = [ImageResource]()
    
    
    func getJsonData( complition: @escaping (ModelData) -> Void) {
        let urlMain = URL(string: API.catigoriesURL)
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
    
    func getImage(url: String, complition: @escaping (ImageResource) -> Void) {
        let resourse = ImageResource(downloadURL: URL(string: url)!, cacheKey: url)
        complition(resourse)
    }
}
