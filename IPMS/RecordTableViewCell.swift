//
//  RecordTableViewCell.swift
//  IPMS
//
//  Created by 🐑🐑🐑 on 16/12/15.
//  Copyright © 2016年 com.Chenziyang. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var parkingSpace: UILabel!
    @IBOutlet weak var timeIn: UILabel!
    @IBOutlet weak var timeOut: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var money: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
