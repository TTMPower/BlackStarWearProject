//
//  realmModel.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 15.07.2021.
//

import Foundation
import RealmSwift

class cacheData: Object {
    @objc dynamic var imageUrl = ""
    @objc dynamic var name = ""
    @objc dynamic var priceOld = ""
    @objc dynamic var price = 0.0
    @objc dynamic var size = ""
}
