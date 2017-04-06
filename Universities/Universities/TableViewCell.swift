//
//  TableViewCell.swift
//  Universities
//
//  Created by Vadim on 4/6/17.
//  Copyright © 2017 Digital Prunes. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: RealmObject?

}
