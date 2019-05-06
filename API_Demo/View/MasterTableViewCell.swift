//
//  MasterTableViewCell.swift
//  API_Demo
//
//  Created by tran duc anh on 5/6/19.
//  Copyright © 2019 Duc Anh. All rights reserved.
//

import UIKit
class TableViewCell: UITableViewCell {
    @IBOutlet weak var magQR: UILabel!
    @IBOutlet weak var place1: UILabel!
    @IBOutlet weak var place2: UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        magQR.text = ""
        place1.text = ""
        place2.text = ""
        time1.text = ""
        time2.text = ""
    }
    
}
