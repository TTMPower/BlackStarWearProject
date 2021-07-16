//
//  BasketViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 14.07.2021.
//

import UIKit
import RealmSwift

class BasketViewController: UIViewController, UITableViewDelegate {
    
    var itemData = [SubCategoryItems]()
    var imagesCell = Network.networkAccess.bucketResourse
    var salePrice = [Double]()
    var doubleE = Double()
    var resultRealm: Results <cacheData>!
    //    var resultSumma: Results <SummaData>!
    let realm = try! Realm()
    //    var notification: NotificationToken?
    var summa = [Double]()
    var forMinus = Double()
    
    
    //    func getSumm() {
    //        if resultRealm.first?.price != nil {
    //            for el in resultRealm {
    //                salePrice.append(el.price)
    //            }
    //            let newArray = salePrice.reduce(0, {$0 + $1})
    //            sumBacket.text = String(newArray)
    //        }
    //    }
    
    func getSum() -> Double {
        summa = [0.0]
        if resultRealm != nil {
            for el in resultRealm {
                summa.append(el.price)
            }
        }
        let strSumma = summa.reduce(0, +)
        forMinus = strSumma
        return strSumma
    }
    
    
    @IBOutlet weak var emptyBucketOutlet: UILabel!
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var sumBacket: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultRealm = realm.objects(cacheData.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.basketTableView.reloadData()
        sumBacket.text = String(getSum())
        print(forMinus)
        
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultRealm?.count != 0 {
            emptyBucketOutlet.isHidden = true
            return resultRealm?.count ?? 0
        } else {
            emptyBucketOutlet.isHidden = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketTableViewCell
        //        let copyIds = realm.objects(cacheData.self)[indexPath.row]
        //        let copies =
        let cellIndex = resultRealm[indexPath.row]
        cell.basketNameCell.text = cellIndex.name
        Network.networkAccess.getImage(url: API.mainURL + cellIndex.imageUrl) { resourse in
            self.imagesCell.insert(resourse, at: 0)
        }
        cell.basketCell.kf.indicatorType = .activity
        cell.basketCell.kf.setImage(with: imagesCell.first, options: [.transition(.fade(0.7))])
        cell.oldPrice.text = cellIndex.priceOld
        cell.price.text = String(cellIndex.price)
        cell.sizeBasket.text = "Размер: \(cellIndex.size)"
        
        let integer: Double? = Double(cellIndex.priceOld ?? "")
        let newInteger: Double? = Double(cellIndex.price)
        
        let oldPrice = "\(String(format: "%.0f", integer ?? "")) руб."
        let newPrice = "\(String(format: "%.0f", newInteger ?? "")) руб."
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.price.text = newPrice
        if integer == nil {
            cell.oldPrice.isHidden = true
        } else {
            cell.oldPrice.isHidden = false
            cell.oldPrice.attributedText = attributeString
            cell.price.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = resultRealm?[indexPath.row] {
                try! realm.write {
                    sumBacket.text = String(forMinus - item.price)
                    forMinus = forMinus - item.price
                    realm.delete(item)
                    basketTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                    basketTableView.reloadData()
                }
                
                
            }
        }
        
        
    }
}
