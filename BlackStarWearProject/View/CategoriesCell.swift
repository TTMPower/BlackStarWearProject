//
//  CategoriesCell.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 01.07.2021.
//

import UIKit

class CategoriesCell: UITableViewCell {
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    func cornerRadius() {
        imageCell.layer.cornerRadius = (imageCell?.frame.size.width ?? 0) / 2
        imageCell?.clipsToBounds = true
        imageCell?.layer.borderWidth = 3.0
        imageCell?.layer.borderColor = UIColor.lightGray.cgColor
    }
}
