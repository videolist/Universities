//
//  UniversityTableViewCell.swift
//  Universities
//
//  Created by Vadim on 4/6/17.
//  Copyright © 2017 Digital Prunes. All rights reserved.
//

import UIKit

class UniversityTableViewCell: TableViewCell {
    @IBOutlet weak var nameAndCountry: UILabel!
    @IBOutlet weak var webLinkTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var item: RealmObject? {
        didSet {
            guard let university = item as? RealmUniversity else {
                return
            }
            nameAndCountry.text = "\(university.name!)"
            webLinkTextView.text = university.webPage
        }
    }

}
