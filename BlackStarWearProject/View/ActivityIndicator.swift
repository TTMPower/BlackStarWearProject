//
//  ActivityIndicator.swift
//  BlackStarWearProject
//
//  Created by Владислав Вишняков on 09.07.2021.
//

import Foundation
import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView?.center ?? CGPoint(x: 0, y: 0)
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView ?? UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)))
    }
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
