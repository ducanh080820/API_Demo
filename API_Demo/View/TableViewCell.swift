//
//  TableViewCell.swift
//  API_Demo
//
//  Created by Duc Anh on 12/4/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
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
        magQR.text = ""
        place1.text = ""
        place2.text = ""
        time1.text = ""
        time2.text = ""
    }
    
}

@IBDesignable
class CustomLabel: UILabel {
    @IBInspectable
    private var cornerRadius: CGFloat = 0.0 {
        didSet {
            setLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    func setLayout() {
        if cornerRadius == -1 {
            layer.cornerRadius = frame.height*0.5
        } else {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
