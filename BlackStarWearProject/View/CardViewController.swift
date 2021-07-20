//
//  CardViewController.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 12.07.2021.
//

import UIKit
import RealmSwift

protocol getSizeFromTable: AnyObject {
    func update(text: String)
}

class CardViewController: UIViewController, UICollectionViewDelegate, getSizeFromTable {
    
    let realm = try! Realm()
    
    static var access = CardViewController()
    var itemData: SubCategoryItems? = nil
    var sizeStr = String()
    var imagesCell = Network.networkAccess.cardResourse
    var placeHolder = Network.networkAccess.placeHolder
    var count = 0
    
    func update(text: String) {
        sizeLabel.text = "Выбран: \(text)"
        sizeStr = text
    }
    
    @IBOutlet weak var AddToBucketOutlet: UIButton!
    @IBOutlet weak var bucketLabel: UILabel!
    @IBAction func AddToBucket(_ sender: Any) {
        if sizeLabel.text == "Выберите размер:" {
            let alert = UIAlertController(title: "Выберите размер", message: "Прежде чем добавить вещь в корзину, нужно выбрать размер", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: {_ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        } else if sizeLabel.text != "Выберите размер:" {
            if count == 2 {
                bucketLabel.text = "Добавленно! Перейти в корзину?"
                AddToBucketOutlet.setImage(UIImage(named: "check"), for: .normal)
                let doublePrice = Double((itemData?.price)!)
                let data = cacheData(value: [itemData?.mainImage! ?? "", itemData?.name ?? "" ,itemData?.oldPrice ?? "", doublePrice!, sizeStr])
                try! realm.write({
                    realm.add(data)
                })
                
                count += 1
            } else if count == 3 {
                tabBarController?.selectedIndex = 1
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
        count = 2
        
    }
    
    func addText() {
        let filtredDescrition = itemData?.description1?.reduce("") {$0 + (String($1) == "&nbcp;" ? " " : String($1))}
        let newDecorate = itemData?.attributes?.filter({$0.decorativeElement != ""})
        let newCountry = itemData?.attributes?.filter({$0.madein != ""})
        let newPrint = itemData?.attributes?.filter({$0.image != ""})
        let newSeason = itemData?.attributes?.filter({$0.sezone != ""})
        let newUhod = itemData?.attributes?.filter({$0.uhod != ""})
        let newSostav = itemData?.attributes?.filter({$0.sostav != ""})
        
        descriprionOutlet.text = "Описание: \(filtredDescrition ?? "Отсутствует")"
        colorOutlet.text = "Цвет: \(itemData?.colorName ?? "Отсутствует")"
        newPrice.text = itemData?.price
        priceOutlet.text = itemData?.oldPrice
        nameOutlet.text = "Название: \(itemData?.name ?? "Отсутствует")"
        articulOutlet.text = "Артикул: \(itemData?.article ?? "Отсутствует")"
        decorateElOutlet.text = "Декоративный элемент: \(newDecorate?.first?.decorativeElement ?? "Отсутствует")"
        printOutlet.text = "Тип изображения: \(newPrint?.first?.image ?? "Отсутствует")"
        countryOutlet.text = "Изотовлено: \(newCountry?.first?.madein ?? "Отсутствует")"
        uhodOutlet.text = "Рекомендация по уходу: \n\(newUhod?.first?.uhod ?? "Отсутствует")"
        sostavOutlet.text = "Ткань: \(newSostav?.first?.sostav ?? "Отсутствует")"
        seasonOutlet.text = "Сезон: \(newSeason?.first?.sezone ?? "Отсутствует")"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoriesCell.access.cornerRadius(view: backgroundViewTop)
        CategoriesCell.access.cornerRadius(view: backgroundViewBotton)
        CategoriesCell.access.cornerRadius(view: backgroundViewMiddle)
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        addText()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Network.networkAccess.fromDoubleToString(double: itemData!.oldPrice!))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        if itemData?.oldPrice == nil {
            priceOutlet.isHidden = true
        } else {
            priceOutlet.isHidden = false
            priceOutlet.attributedText = attributeString
            newPrice.isHidden = false
        }
        newPrice.text = "Цена: \(Network.networkAccess.fromDoubleToString(double: itemData?.price ?? "Error"))"
    }
}

extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if itemData?.productImages?.isEmpty == true {
            return 1
        } else {
            return itemData?.productImages?.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as! cardCollectionViewCell
        cell.cardImage.kf.indicatorType = .activity
            if itemData?.productImages?.isEmpty == true {
                let placeholdURL = itemData?.mainImage ?? ""
                Network.networkAccess.getImage(url: API.mainURL + placeholdURL) { resourse in
                    self.placeHolder = resourse
                    cell.cardImage.kf.setImage(with: self.placeHolder)
                }
            } else {
                let indexPathURL = itemData?.productImages?[indexPath.row].imageURL ?? ""
                Network.networkAccess.getImage(url: API.mainURL + indexPathURL) { resourse in
                    self.imagesCell.append(resourse)
                    cell.cardImage.kf.setImage(with: self.imagesCell[indexPath.row])
                }
            }
            CategoriesCell.access.cornerRadius(view: cell.cardImage)

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
        }
    }
