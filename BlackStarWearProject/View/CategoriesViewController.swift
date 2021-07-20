//
//  ViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import UIKit
import Kingfisher

class CategoriesViewController: UIViewController, UITableViewDelegate {
    
    var result = ModelData()
    var categoriesName = [String]()
    var urlImageCategories = [String]()
    
    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        title = "Категории"
        getData()
    }
    
    func getData() {
        Network.networkAccess.getJsonData(url: API.catigoriesURL) { complition in
            DispatchQueue.main.async {
                self.result = complition
                for el in self.result.values {
                    self.categoriesName.append(el.name ?? "")
                    self.urlImageCategories.append(el.image ?? "")
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
        let resultCell = result.values.sorted(by: {$0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? ""})[indexPath.row]
        cell.labelCell.text = resultCell.name
        cell.backgroundCell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellISubCat", sender: self)
        categoriesTableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SubCatViewController {
            let resultCell = result.values.sorted(by: {($0.name?.lowercased() ?? "") < $1.name?.lowercased() ?? ""})
            destination.data = resultCell[categoriesTableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
