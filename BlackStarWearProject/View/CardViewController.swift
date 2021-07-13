//
//  CardViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 12.07.2021.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate {
    
    var itemData: SubCategoryItems? = nil
    var images = [String]()
    var imagess = [String]()
    var stringID = String()
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var articulOutlet: UILabel!
    @IBOutlet weak var sostavOutlet: UILabel!
    @IBOutlet weak var descriprionOutlet: UILabel!
    @IBOutlet weak var uhodOutlet: UILabel!
    @IBOutlet weak var countryOutlet: UILabel!
    @IBOutlet weak var seasonOutlet: UILabel!
    @IBOutlet weak var printOutlet: UILabel!
    @IBOutlet weak var decorateElOutlet: UILabel!
    @IBOutlet weak var colorOutlet: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var navigartioBar: UINavigationItem!
    
    func getText() {
        for attributes in itemData!.attributes! {
            self.sostavOutlet.text = attributes.sostav
            self.uhodOutlet.text = attributes.uhod
            self.seasonOutlet.text = attributes.sezone
            self.printOutlet.text = attributes.image
            self.decorateElOutlet.text = attributes.decorativeElement
            self.countryOutlet.text = attributes.madein
            print(attributes.madein)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        nameOutlet.text = itemData?.name
        articulOutlet.text = itemData?.article
        descriprionOutlet.text = itemData?.description1
        colorOutlet.text = itemData?.colorName
        priceOutlet.text = itemData?.price
        getText()
            
    }
}


extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (itemData?.productImages?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as! cardCollectionViewCell
        let indexImage = itemData?.productImages![indexPath.row].imageURL
        var images = Network.networkAccess.cardResourse
        Network.networkAccess.getImage(url: API.mainURL + indexImage!) { resourse in
            images.append(resourse)
        }
        cell.cardImage.kf.setImage(with: images.first)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let wCell = frameVC.width / CGFloat(1)
        let hCell = wCell
        return CGSize(width: wCell, height: hCell)
    }
    
    
}
