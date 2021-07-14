//
//  CardViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 12.07.2021.
//

import UIKit

protocol getSizeFromTable: AnyObject {
    func update(text: String)
}

class CardViewController: UIViewController, UICollectionViewDelegate, getSizeFromTable {
    func update(text: String) {
        sizeLabel.text = "Выбран: \(text)"
    }
    
    
    static var access = CardViewController()
    var itemData: SubCategoryItems? = nil
    var images = [String]()
    var imagess = [String]()
    var stringID = String()
    var imagesCell = Network.networkAccess.cardResourse
    var count = 0
    
    @IBOutlet weak var AddToBucketOutlet: UIButton!
    @IBOutlet weak var bucketLabel: UILabel!
    @IBAction func AddToBucket(_ sender: Any) {
        if sizeLabel.text != "Выберите размер:" {
        if count == 0 {
            bucketLabel.text = "Добавленно! Перейти в корзину?"
            AddToBucketOutlet.setImage(UIImage(named: "check"), for: .normal)
            count += 1
        } else if count == 1 {
            performSegue(withIdentifier: "bucketSegue", sender: sender)
        }
    }
    }
    
    @IBOutlet weak var uhodOutlet: UILabel!
    @IBOutlet weak var MenuOutlet: UIView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var descriprionOutlet: UILabel!
    @IBOutlet weak var articulOutlet: UILabel!
    @IBOutlet weak var decorateElOutlet: UILabel!
    @IBOutlet weak var navigartioBar: UINavigationItem!
    @IBOutlet weak var printOutlet: UILabel!
    @IBOutlet weak var backgroundViewBotton: UIView!
    @IBOutlet weak var backgroundViewMiddle: UIView!
    @IBOutlet weak var backgroundViewTop: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var seasonOutlet: UILabel!
    @IBOutlet weak var sostavOutlet: UILabel!
    @IBOutlet weak var countryOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var colorOutlet: UILabel!
    
    @IBAction func sizeAction(_ sender: Any) {
        AddToBucketOutlet.setImage(UIImage(named: "clothes"), for: .normal)
        bucketLabel.text = "Добавить в корзину:"
        count = 0
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesCell.access.cornerRadius(view: backgroundViewTop)
        CategoriesCell.access.cornerRadius(view: backgroundViewBotton)
        CategoriesCell.access.cornerRadius(view: backgroundViewMiddle)
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        nameOutlet.text = "Название: \(itemData?.name ?? "Отсутствует")"
        articulOutlet.text = "Артикул: \(itemData?.article ?? "Отсутствует")"
        descriprionOutlet.text = "Описание: \(itemData?.description1 ?? "Отсутствует")"
        colorOutlet.text = "Цвет: \(itemData?.colorName ?? "Отсутствует")"
        newPrice.text = itemData?.price
        priceOutlet.text = itemData?.oldPrice
        
        
        let newDecorate = itemData?.attributes?.filter({$0.decorativeElement != ""})
        let newCountry = itemData?.attributes?.filter({$0.madein != ""})
        let newPrint = itemData?.attributes?.filter({$0.image != ""})
        let newSeason = itemData?.attributes?.filter({$0.sezone != ""})
        let newUhod = itemData?.attributes?.filter({$0.uhod != ""})
        let newSostav = itemData?.attributes?.filter({$0.sostav != ""})
        decorateElOutlet.text = "Декоративный элемент: \(newDecorate?.first?.decorativeElement ?? "Отсутствует")"
        printOutlet.text = "Тип изображения: \(newPrint?.first?.image ?? "Отсутствует")"
        countryOutlet.text = "Изотовлено: \(newCountry?.first?.madein ?? "Отсутствует")"
        uhodOutlet.text = "Рекомендация по уходу: \(newUhod?.first?.uhod ?? "Отсутствует")"
        sostavOutlet.text = "Ткань: \(newSostav?.first?.sostav ?? "Отсутствует")"
        seasonOutlet.text = "Сезон: \(newSeason?.first?.sezone ?? "Отсутствует")"
        
        
        let newPrices: Double! = Double(itemData!.price ?? "")
        let oldPrices: Double! = Double(itemData!.oldPrice ?? "")
        let newPriceRub = "\(String(format: "%.0f", newPrices ?? "")) руб."
        let oldPriceRub = "\(String(format: "%.0f", oldPrices ?? "")) руб."
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPriceRub)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        if oldPrices == nil {
            priceOutlet.isHidden = true
        } else {
            priceOutlet.isHidden = false
            priceOutlet.attributedText = attributeString
            newPrice.isHidden = false
        }
        newPrice.text = "Цена: \(newPriceRub)"
        print(itemData?.offers)
    }
}

extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (itemData?.productImages?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as! cardCollectionViewCell
        let indexImage = itemData?.productImages![indexPath.row].imageURL
        Network.networkAccess.getImage(url: API.mainURL + indexImage!) { resourse in
            self.imagesCell.append(resourse)
        }
        CategoriesCell.access.cornerRadius(view: cell.cardImage)
        cell.cardImage.kf.setImage(with: imagesCell[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameVC = collectionView.frame
        let wCell = frameVC.width / CGFloat(1)
        let hCell = wCell
        return CGSize(width: wCell, height: hCell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ZoomSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ZoomSegue" {
            if let detailVC = segue.destination as? ZoomViewController {
                if cardCollectionView.indexPathsForSelectedItems != nil {
                    detailVC.itemData = itemData
                }
            }
        }
        if segue.identifier == "pickerSegue" {
            guard let destination = segue.destination as? SizesViewController else { return }
            destination.itemData = itemData
            destination.delegate = self
        }
        if segue.identifier == "bucketSegue" {
            guard let destination = segue.destination as? BasketViewController else { return }
            destination.itemData = itemData
        }
    }
}
