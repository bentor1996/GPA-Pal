//
//  CourseListTableViewCell.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/14/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class CourseListTableViewCell: UITableViewCell {

    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var courseGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
