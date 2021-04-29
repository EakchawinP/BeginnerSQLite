//
//  ItemCellTableViewCell.swift
//  DevSQLite
//
//  Created by SD-M004 on 26/4/2564 BE.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lb_FirstName: UILabel!
    
    static let identify = "itemCell"
    static func nib() -> UINib {
        return UINib(nibName: "ItemCellTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
