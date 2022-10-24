//
//  Shadow.swift
//  HomeWork14
//
//  Created by Darya Grabowskaya on 22.10.22.
//

import UIKit

protocol Shadow where Self: UIView {
    func makeShadow(color: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat)
    func deleteShadow()
}

extension Shadow {
    func makeShadow(
        color: UIColor = .green,
        shadowOpacity: Float = 1,
        shadowOffset: CGSize = .zero,
        shadowRadius: CGFloat = 10
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
    
    func deleteShadow() {
        layer.shadowOpacity = 0
    }
}

