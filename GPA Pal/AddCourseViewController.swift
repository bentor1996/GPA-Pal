//
//  AddCourseViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class AddCourseViewController: UIViewController {
    
    // this will initally be an empty list of Managed objects
    // This View Controller will need to create a new course object and append it to this list
    var courses = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add New Class"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
