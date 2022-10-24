//
//  Blur.swift
//  HomeWork14
//
//  Created by Darya Grabowskaya on 22.10.22.
//

import UIKit

protocol Blur where Self: UIView {
    func makeBlur()
}

extension Blur {
    func makeBlur() {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        blurEffectView.tag = 1337
        addSubview(blurEffectView)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            blurEffectView.alpha = 0.7
        }, completion: nil)
    }
    
}
