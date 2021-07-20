//
//  ItemsViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 08.07.2021.
//

import UIKit

class ItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let shared = ItemsViewController()
    var itemDatas = Subcategory()
    var id = [SortOrder]()
    var idInt = Int()
    var stringId = [String]()
    var itemCell = [SubCategoryItems]()
    
    
    
    @IBOutlet weak var navigartioBar: UINavigationItem!
    func getIDS() {
        if let unwrapDatas = itemDatas.id {
            id.append(unwrapDatas)
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
        self.showSpinner()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        getIDS()
        getItems()
        navigartioBar.title = itemDatas.name
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemsCollectionViewCell
        let index = itemCell[indexPath.row]
        let mainImg = index.mainImage ?? ""
        cell.itemImageCell.kf.indicatorType = .activity
        var images = Network.networkAccess.imageResourse
        cell.nameItemCell.text = index.name
        
        Network.networkAccess.getImage(url: API.mainURL + mainImg) { resourse in
            images.append(resourse)
        }
        
        cell.itemImageCell.kf.setImage(with: images.first, placeholder: UIImage(named: "placeholder")?.kf.blurred(withRadius: 10), options: [.transition(.fade(0.7))])
        
        
        let integer: Double? = Double(index.oldPrice ?? "")
        let newInteger: Double? = Double(index.price ?? "")
        
        let oldPrice = "\(String(format: "%.0f", integer ?? "")) руб."
        let newPrice = "\(String(format: "%.0f", newInteger ?? "")) руб."
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cardSeuge", sender: indexPath)
        myCollectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 15, height:  view.frame.width / 1.5)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardSeuge" {
            if let detailVC = segue.destination as? CardViewController {
                if let paths = myCollectionView.indexPathsForSelectedItems {
                    let row = paths[0].row
                    detailVC.itemData = itemCell[row]
                }
            }
        }
    }
}
