//
//  InfoCell.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 24/04/22.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    static let height:CGFloat = 60
    
    func setData(key: String, value: String){
        self.lblKey.text = key
        self.lblValue.text = value
    }
    
}
