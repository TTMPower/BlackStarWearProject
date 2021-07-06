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
    var categoriesName = [String]()
    var urlImageCategories = [String]()
    var categoriesImage = [ImageResource]()
    var arraySubCategories = [Category]()
    
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
                    
//                    for el in el.subcategories {
//                        self.res = el.iconImage?.replacingOccurrences(of: "", with: "image/catalog/style/modile/icons-03.png")
//                        }
//                    }
//                    el.subcategories.filter({$0.name != "Маски"}).filter({$0.name != "Очки"}).filter({$0.name != "Кошельки"}).filter({$0.name != "COLOR"}).filter({$0.name != "Black Star Mafia"}).filter({$0.name != "DEFORM"}).filter({$0.name != "NINJA"}).filter({$0.name != "Союзмультфильм"}).filter({$0.name != "Bootleg"}).filter({$0.name != "BSW Design"}).filter({$0.name != "RUS"}).filter({$0.name != "LUX"}).filter({$0.name != "Lion"}).filter({$0.name != "Crew"}).filter({$0.name != "WorldWide"}).filter({$0.name != "Коллекция R.U.S."}).filter({$0.name != "Летняя коллекция"}).filter({$0.name != "Pattern"}).filter({$0.name != "Winter collection"}).filter({$0.name != "Generation 13"}).filter({$0.name != "AS"})
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
            let imageURL = resultCell.image!
            Network.networkAccess.getImage(url: API.mainURL + imageURL) { resourse in
                images.append(resourse)
            }
            cell.imageCell.kf.setImage(with: images.first, options: [.scaleFactor(94)])
            cell.labelCell.text = resultCell.name
        cell.backgroundCell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellISubCat", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SubCatViewController {
            let resultCell = result.values.sorted(by: {($0.name?.lowercased())! < $1.name!.lowercased()})
            destination.data = resultCell[categoriesTableView.indexPathForSelectedRow!.row]
            }
        }
    }
