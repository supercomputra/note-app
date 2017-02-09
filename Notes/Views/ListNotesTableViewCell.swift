//
//  ListNotesTableViewCell.swift
//  Notes
//
//  Created by Zulwiyoza Putra on 10/15/16.
//  Copyright © 2016 Zulwiyoza Putra. All rights reserved.
//

import UIKit

class ListNotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTitleLabel: UILabel!

    @IBOutlet weak var noteContentPreviewLabel: UILabel!
    
    @IBOutlet weak var noteModificationTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
