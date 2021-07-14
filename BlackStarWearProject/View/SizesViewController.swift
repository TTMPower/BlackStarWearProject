//
//  SizesViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 14.07.2021.
//

import UIKit

class SizesViewController: UIViewController, UITableViewDelegate {
    
    weak var delegate: getSizeFromTable?

    var itemData: SubCategoryItems? = nil
    var sizeModel = [Offers]()
    var currentSize = String()
    
    func getString() {
        for el in itemData?.offers ?? [] {
            sizeModel.append(el)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getString()
    }
}

extension SizesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizeModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell")!
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = sizeModel[indexPath.row].size
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSize = sizeModel[indexPath.row].size!
        delegate?.update(text: currentSize)
        dismiss(animated: true)
    }
    
}
