//
//  SubCatViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 02.07.2021.
//

import UIKit

class SubCatViewController: UIViewController, UITableViewDelegate {

    var data: ModelDataValue? = nil
    var iconSubImage = [String]()
    var nameSubImage = [String]()
    var filterData: ModelDataValue? = nil
    var id = [SortOrder]()
    var idInt = Int()
    var stringId = [String]()
    
    
    
    func getIDS() {
        for el in data!.subcategories {
            id.append(el.id!)
    }
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
            
            Network.networkAccess.getJsonDataSub(url: API.items + el, complition: { complition in
        })
        }
    }
    
    

    @IBOutlet weak var navigatorBar: UINavigationItem!
    
    @IBOutlet weak var subTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for el in data!.subcategories {
            iconSubImage.append(el.iconImage!)
            nameSubImage.append(el.name!)
        }
        
        navigatorBar.title = data?.name
        getIDS()
        getItems()
        print(stringId)
        

    }
    
}

extension SubCatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameSubImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryCell") as! SubCatTableViewCell
        let indexPathcell = data?.subcategories[indexPath.row]
        var images = Network.networkAccess.imageSubResourse
        let imageURL = (indexPathcell?.iconImage)!
       
        Network.networkAccess.getImage(url: API.mainURL + imageURL) { resourse in
            images.append(resourse)
        }
        cell.subCategoryImage.kf.setImage(with: images.first, placeholder: UIImage(named: "clothes") ,options: [.scaleFactor(94)])
        cell.subCategoryLabel.text = indexPathcell?.name
        cell.backgroundCell.layer.cornerRadius = 10
        return cell
    }
    
    
}
