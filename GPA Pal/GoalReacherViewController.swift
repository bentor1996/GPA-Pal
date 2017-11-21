//
//  GoalReacherViewController.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/14/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class GoalReacherViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var selectedSection: NSManagedObject?
    var course: NSManagedObject?
    var courseID: NSManagedObjectID?
    var sections: [NSManagedObject]?
    @IBOutlet weak var goalLabel: UIView!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = getSectionList(course: course!)
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections![row].value(forKey: "name") as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = sections![row]
    }
    
    func calculateRequiredGrade() -> Float {
        // get all the different sections
        // get the weights for those sections
        // get all the grades for 
        
        return 0.0
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
