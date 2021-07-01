//
//  ViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import UIKit
import Kingfisher

class CategoriesViewController: UIViewController, UITableViewDelegate {
    
    var complit = ModelData()
    var result = ModelData()
    var resultData = ModelDataValue()
    var categoriesName = [String]()
    var urlImageCategories = [String]()
    var categoriesImage = [ImageResource]()
    
    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        title = "Категории"
        getData()
    }
    
    
    
    func getData() {
        Network.networkAccess.getJsonData { complition in
            DispatchQueue.main.async {
                self.result = complition.filter({$0.value.name! != "Коллекции"}).filter({$0.value.name! != "Marketplace"}).filter({$0.value.name != "Последний размер"})
                for el in self.result.values {
                    self.categoriesName.append(el.name!)
                    self.urlImageCategories.append(el.image!)
                    self.categoriesTableView.reloadData()
                }
            }
        }
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath as IndexPath) as! CategoriesCell
        let resultCell = result.values.sorted(by: {$0.name!.lowercased() < $1.name!.lowercased()})[indexPath.row]
        var images = Network.networkAccess.imageResourse
//        let imageURL = urlImageCategories[indexPath.row]
        let imageURL = resultCell.image!
        Network.networkAccess.getImage(url: API.mainURL + imageURL) { resourse in
            images.append(resourse)
        }
        
        cell.imageCell.kf.setImage(with: images.first, options: [.scaleFactor(94)])
//        cell.labelCell.text = categoriesName[indexPath.row]
        cell.labelCell.text = resultCell.name
        cell.backgroundCell.layer.cornerRadius = 10
        //        cell.cornerRadius()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "segueToSubCategory", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? SubCategoriesViewController {
                destination.data = result.values.first?.subcategories?[categoriesTableView.indexPathForSelectedRow!.row]
            }
        }
    
    
}
