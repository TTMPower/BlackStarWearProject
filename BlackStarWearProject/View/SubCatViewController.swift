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
    
    
    @IBOutlet weak var subTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for el in data!.subcategories {
            iconSubImage.append(el.iconImage!)
            nameSubImage.append(el.name!)
        }
        
    }
}

extension SubCatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameSubImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryCell") as! SubCatTableViewCell
        let indexPathcell = data?.subcategories.filter({($0.iconImage?.contains("/n"))!})[indexPath.row]
        var images = Network.networkAccess.imageSubResourse
        let imageURL = (indexPathcell?.iconImage)!
        Network.networkAccess.getImage(url: API.mainURL + imageURL) { resourse in
            images.append(resourse)
        }
        cell.subCategoryImage.kf.setImage(with: images.first, options: [.scaleFactor(94)])
        cell.subCategoryLabel.text = indexPathcell?.name
        return cell
    }
    
    
}
