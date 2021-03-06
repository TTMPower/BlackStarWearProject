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
    
    @IBOutlet weak var navigatorBar: UINavigationItem!
    @IBOutlet weak var subTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for el in data?.subcategories ?? [] {
            iconSubImage.append(el.iconImage ?? "")
            nameSubImage.append(el.name ?? "")
        }
        navigatorBar.title = data?.name
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
        let imageURL = indexPathcell?.iconImage ?? ""
        cell.subCategoryImage.kf.indicatorType = .activity
       
        Network.networkAccess.getImage(url: API.mainURL + imageURL) { resourse in
            images.append(resourse)
        }
        cell.subCategoryImage.kf.setImage(with: images.first, placeholder: UIImage(named: "clothes") ,options: [.scaleFactor(94),.transition(.fade(0.7))])
        cell.subCategoryLabel.text = indexPathcell?.name
        cell.backgroundCell.layer.cornerRadius = 10
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemsSegue", sender: self)
        subTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ItemsViewController {
            let resultCell = data?.subcategories
            destination.itemDatas = resultCell?[subTableView.indexPathForSelectedRow?.row ?? 0] ?? Subcategory()
            }
        }
    
}
