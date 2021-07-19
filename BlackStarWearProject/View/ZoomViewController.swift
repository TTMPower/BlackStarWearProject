//
//  ZoomViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 13.07.2021.
//

import UIKit

class ZoomViewController: UIViewController, UICollectionViewDelegate {
    
    var itemData: SubCategoryItems? = nil
    var indexPaths: IndexPath!
    var imagesCell = Network.networkAccess.cardResourse
    var placeHold = Network.networkAccess.placeHolder
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var zoomCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomCollectionView.delegate = self
        zoomCollectionView.dataSource = self
    }
}


extension ZoomViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if itemData?.productImages?.isEmpty == true {
            return 1
        } else {
            return itemData?.productImages?.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoomCell", for: indexPath) as! ZoomCollectionViewCell
//        let indexImage = itemData?.productImages![indexPath.row].imageURL
        cell.zoomCell.kf.indicatorType = .activity
        if itemData?.productImages?.isEmpty == true {
            Network.networkAccess.getImage(url: API.mainURL + (itemData?.mainImage)! , complition: { resourse in
                self.placeHold = resourse
                cell.zoomCell.kf.setImage(with: self.placeHold, options: [.transition(.fade(0.7))])
            })
    } else {
        Network.networkAccess.getImage(url: API.mainURL + (itemData?.productImages![indexPath.row].imageURL)!) { resourse in
    self.imagesCell.append(resourse)
    cell.zoomCell.kf.setImage(with: self.imagesCell[indexPath.row], options: [.transition(.fade(0.7))])
    }
    }
    CategoriesCell.access.cornerRadius(view: cell.zoomCell)
    
    return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let wCell = frameVC.width
        let hCell = frameVC.height
        return CGSize(width: wCell, height: hCell)
    }
    
    
}
