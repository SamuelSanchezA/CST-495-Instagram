//
//  PostCell.swift
//  instagram-assignment
//
//  Created by Samuel on 2/12/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

     
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
