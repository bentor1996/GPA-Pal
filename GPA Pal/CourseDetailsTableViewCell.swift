//
//  CourseDetailsTableViewCell.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/19/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class CourseDetailsTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var sectionType: UILabel!
    @IBOutlet weak var sectionGrade: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
