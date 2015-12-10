//
//  RecordTableViewCell.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/7/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var excerciseLabel :UILabel!
    @IBOutlet weak var memberLabel :UILabel!
    @IBOutlet weak var memberRecordLabel :UILabel!
    @IBOutlet weak var memberRecordTextField :UITextField!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
