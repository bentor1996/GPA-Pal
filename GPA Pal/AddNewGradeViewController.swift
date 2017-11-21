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
    
    var alertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Grade"
        course = getCourseWithID(courseID: courseID!)
        sections = getSectionList(course: course!)
        self.picker.delegate = self
        self.picker.dataSource = self
        selectedSection = sections![0]
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
        print(selectedSection!)
        
    }
    
    @IBAction func bttnSaved(_ sender: Any) {
        addNewAssignment()
    }
    
    func addNewAssignment() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Assignment", in: managedContext)
        
        let assignment = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        assignment.setValue(nameLabel?.text, forKey: "name")
        assignment.setValue(Float(gradeLabel.text!), forKey: "grade")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        let sectionID = selectedSection?.objectID
        //print(sectionID)
        //print(assignment)
        addAssignmentToSection(sectionID: sectionID!, assignmentList: assignment)
        setAverage()
        
    }
    
    func setAverage() {
        if course?.value(forKey: "totalType") as? String == "Percent" {
            var total = 0
            let assignmentList = getAssignmentList(section: selectedSection!)
            for ass in assignmentList {
                total += ass.value(forKey: "grade") as! Int
            }
            let average = total/assignmentList.count
            setSectionAverage(section: selectedSection!, average: Float(average))
            print("Percent, Done new average is \(average)")
        } else {
            var total = 0
            let assignmentList = getAssignmentList(section: selectedSection!)
            for ass in assignmentList {
                total += ass.value(forKey: "grade") as! Int
            }
            //var average = total/(selectedSection?.value(forKey: "weight") as! Int)
            let weight = selectedSection?.value(forKey: "weight") as! Float
            let average = (Float(total)/weight) * 100
            setSectionAverage(section: selectedSection!, average: Float(average))
            print("number, new average is \(average)")
        }
    }
    
    func displayMessage (_message:String){
        
        self.alertController = UIAlertController(title: "Message", message: _message , preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (action:UIAlertAction) in
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
        
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

