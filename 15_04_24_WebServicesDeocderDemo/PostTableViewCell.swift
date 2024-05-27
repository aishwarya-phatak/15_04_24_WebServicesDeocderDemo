//
//  PostTableViewCell.swift
//  15_04_24_WebServicesDeocderDemo
//
//  Created by Vishal Jagtap on 27/05/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTagLabel: UILabel!
    @IBOutlet weak var postReactionLikesLabel: UILabel!
    @IBOutlet weak var postReactionDislikesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
