//
//  BasketViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 14.07.2021.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDelegate {

    var itemData: SubCategoryItems? = nil
    
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var sumBacket: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketTableViewCell
        return cell
    }
    
    
}
