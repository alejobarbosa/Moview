//
//  InfoViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import UIKit

class InfoViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContentTable: UIView!
    @IBOutlet weak var tableInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    private func setUpViews(){
        self.lblTitle.text = InfoModel.Texts.title
        self.viewContentTable.layer.cornerRadius = 10
        self.tableInfo.delegate = self
        self.tableInfo.dataSource = self
        self.tableInfo.register(InfoCell.nib,
                                forCellReuseIdentifier: InfoCell.identifier)
        self.tableInfo.isScrollEnabled = false
        self.tableInfo.reloadData()
    }

}
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier,
                                                    for: indexPath) as? InfoCell {
            var key = ""
            var value = ""
            switch indexPath.row {
            case 0:
                key = InfoModel.Texts.keyTest
                value = InfoModel.Texts.valueTest
                break
            case 1:
                key = InfoModel.Texts.keyVersion
                value = InfoModel.Texts.valueVersion
                break
            case 2:
                key = InfoModel.Texts.keyName
                value = InfoModel.Texts.valueName
                break
            default:
                key = InfoModel.Texts.keyFeedback
                value = InfoModel.Texts.valueFeedback
                break
            }
            cell.setData(key: key, value: value)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InfoCell.height
    }
    
}
