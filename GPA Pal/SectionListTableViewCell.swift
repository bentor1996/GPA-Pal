//
//  SectionListTableViewCell.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/18/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SectionListTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionType: UILabel!
    @IBOutlet weak var sectionGrade: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
