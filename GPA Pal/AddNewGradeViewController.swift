//
//  AddNewGradeViewController.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/14/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class AddNewGradeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var gradeLabel: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var selectedSection: NSManagedObject?
    
    var course: NSManagedObject?
    
    var courseID: NSManagedObjectID?
    
    var sections: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        course = getCourseWithID(courseID: courseID!)
        sections = getSectionList(course: course!)
        self.picker.delegate = self
        self.picker.dataSource = self
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
    
    @IBAction func bttnSaved(_ sender: Any) {
        
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

