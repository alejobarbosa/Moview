//
//  UIView.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 24/04/22.
//

import UIKit

extension UIView {
    
    func addConstraintTopParent( constant: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: constant).isActive = true
    }
    
    func addWidthConstraintParent(multiplier: CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func addBottomConstraintParent(constant: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: constant).isActive = true
    }
    
    func addConstraintXCenterParent(multiplier: CGFloat = 1, constant: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .centerX,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.isActive = true
        self.superview!.addConstraint(constraint)
    }
    
}
