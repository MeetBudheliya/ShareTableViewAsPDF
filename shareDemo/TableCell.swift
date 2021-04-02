//
//  TableCell.swift
//  shareDemo
//
//  Created by Adsum MAC 1 on 02/04/21.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
