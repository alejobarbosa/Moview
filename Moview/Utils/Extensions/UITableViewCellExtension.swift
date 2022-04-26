//
//  UITableViewCellExtension.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
}
