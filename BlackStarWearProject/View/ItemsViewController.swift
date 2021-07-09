//
//  ItemsViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 08.07.2021.
//

import UIKit

class ItemsViewController: UIViewController, UICollectionViewDelegate {
    
    var itemDatas = Subcategory()
    var id = [SortOrder]()
    var idInt = Int()
    var stringId = [String]()
    var itemData = [ItemsData]()
    var itemCell = [SubCategoryItems]()
    var count = Int()

    
    func getIDS() {
        id.append(itemDatas.id!)
        id.forEach {(value) in
            if case .string(let integer) = value {
                self.stringId.append(integer)
            }
            if case .integer(let int) = value {
                self.idInt = int
            }
        }
        let myString = String(idInt)
        stringId.append(myString)
    }
    
    func getItems() {
        for el in stringId {
            Network.networkAccess.getJsonDataSub(url: API.items + el) { complition in
                DispatchQueue.main.async {
                    self.itemCell += complition
                    self.myCollectionView.reloadData()
                }
               
            }
        }
    }
    
    



    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        getIDS()
        getItems()
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemsCollectionViewCell
        let index = itemCell[indexPath.row]
        var images = Network.networkAccess.imageSubResourse
        cell.nameItemCell.text = index.name
        Network.networkAccess.getImage(url: API.mainURL + index.mainImage!) { resourse in
            images.append(resourse)
        }
        cell.itemImageCell.kf.setImage(with: images.first)
        let integer: Double? = Double(index.price!)
        cell.priceItemCell.text = "\(String(format: "%.0f", integer!)) руб."
        return cell
    }
    
    
}
