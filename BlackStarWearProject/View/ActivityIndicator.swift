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
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
