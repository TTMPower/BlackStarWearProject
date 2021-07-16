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

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var zoomCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomCollectionView.delegate = self
        zoomCollectionView.dataSource = self
        print(CardViewController.access.itemData?.offers)
    }
}


extension ZoomViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (itemData?.productImages?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zoomCell", for: indexPath) as! ZoomCollectionViewCell
        let indexImage = itemData?.productImages![indexPath.row].imageURL
        cell.zoomCell.kf.indicatorType = .activity
        Network.networkAccess.getImage(url: API.mainURL + indexImage!) { resourse in
            self.imagesCell.append(resourse)
        }
        CategoriesCell.access.cornerRadius(view: cell.zoomCell)
        cell.zoomCell.kf.setImage(with: imagesCell[indexPath.row], options: [.transition(.fade(0.7))])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let wCell = frameVC.width
        let hCell = frameVC.height
        return CGSize(width: wCell, height: hCell)
    }
    
    
}
