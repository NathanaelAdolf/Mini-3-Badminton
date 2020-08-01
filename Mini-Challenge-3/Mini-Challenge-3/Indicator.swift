//
//  Indicator.swift
//  Tourneo
//
//  Created by Griffin on 01/08/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

var getView: UIView?

extension UIViewController {
 
    func showSpinner(){
        
        getView = UIView(frame: self.view.bounds)
        getView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.center = getView!.center
        ai.startAnimating()
        
        getView?.addSubview(ai)
        self.view.addSubview(getView!)
        print("indicator")
    }
    
    func removeSpinner(){
        getView?.removeFromSuperview()
        getView = nil
    }
}
