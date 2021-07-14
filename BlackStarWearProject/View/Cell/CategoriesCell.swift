//
//  CategoriesCell.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
    static let access = CategoriesCell()
    
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    func cornerRadius(view: UIView) {
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
}
