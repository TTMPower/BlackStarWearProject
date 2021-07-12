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
    var placeholderImage = [ProductImages]()
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
            Network.networkAccess.getJsonDataSub(url: API.items + el) { complition, datas  in
                DispatchQueue.main.async {
                    self.itemCell += complition
                    self.placeholderImage += datas
                    self.myCollectionView.reloadData()
                }
                
            }
        }
    }
    
    
    
    
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        getIDS()
        getItems()
        print(placeholderImage)
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemsCollectionViewCell
        
        let index = itemCell[indexPath.row]
        cell.itemImageCell.kf.indicatorType = .activity
        var images = Network.networkAccess.imageResourse
        cell.nameItemCell.text = index.name
        
        Network.networkAccess.getImage(url: API.mainURL + index.mainImage!) { resourse in
            images.append(resourse)
        }
        
        cell.itemImageCell.kf.setImage(with: images.first, placeholder: UIImage(named: "placeholder")!.kf.blurred(withRadius: 10), options: [.transition(.fade(0.7))])
        
        let integer: Double? = Double(index.oldPrice ?? "")
        let newInteger: Double? = Double(index.price ?? "")
        
        let oldPrice = "\(String(format: "%.0f", integer ?? "")) руб."
        let newPrice = "\(String(format: "%.0f", newInteger ?? "")) руб."
//        if integer == 0 {
//            cell.priceItemCell.isHidden = true
//        }
        print("oldPrice \(oldPrice)")
        print("integer \(integer)")
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.newPriceItemCell.text = newPrice
        cell.viewBackground.layer.cornerRadius = 15
        if integer == nil {
            cell.priceItemCell.isHidden = true
            cell.lowCost.isHidden = true
        } else {
            cell.priceItemCell.isHidden = false
            cell.priceItemCell.attributedText = attributeString
            cell.lowCost.isHidden = false
        }
        self.removeSpinner()
        return cell
    }
}
