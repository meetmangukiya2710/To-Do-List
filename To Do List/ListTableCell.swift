//
//  ListTableCell.swift
//  To Do List
//
//  Created by R95 on 05/09/24.
//

import UIKit

class ListTableCell: UITableViewCell {
    
    @IBOutlet weak var taskNameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var priorityLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
