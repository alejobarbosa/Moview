//
//  EmptyCell.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 24/04/22.
//

import UIKit

class EmptyCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    static let height:CGFloat = 500
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContent.layer.cornerRadius = 10
        self.lblDescription.text = FavoritesModel.Texts.cellDescription
    }
    
}
