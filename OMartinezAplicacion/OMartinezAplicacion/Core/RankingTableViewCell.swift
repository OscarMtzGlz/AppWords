//
//  RankingTableViewCell.swift
//  OMartinezAplicacion
//
//  Created by MacBookMBA2 on 25/01/23.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var palabraslabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
