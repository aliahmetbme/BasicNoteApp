//
//  NoteViewCell.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 20.07.2024.
//

import UIKit

class NoteViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var note: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
