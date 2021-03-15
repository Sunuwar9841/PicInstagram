//
//  PostCell.swift
//  Pastagram
//
//  Created by alisha.sunuwar on 3/14/21.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
