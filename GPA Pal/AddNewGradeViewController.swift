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
        if nameLabel.text! == "" || gradeLabel.text! == "" {
            displayMessage(_message: "Enter an assignment name and grade to add a grade.")
        } else if (gradeLabel.text?.isNumeric)! == false {
            displayMessage(_message: "Enter a number for the grade.")
        } else {
            if course?.value(forKey: "totalType") as? String == "Percent" {
                if (Int(gradeLabel.text!)!) >= 0 && (Int(gradeLabel.text!)!) <= 100 {
                    YouSure()
                } else {
                    displayMessage(_message: "Enter a grade between 0 and 100.")
                }
            } else {
                if (Int(gradeLabel.text!)!) >= 0 && (Int(gradeLabel.text!)!) <= Int((selectedSection?.value(forKey: "weight") as? Float)!) {
                    YouSure()
                } else {
                    displayMessage(_message: "Enter a grade between 0 and \((selectedSection?.value(forKey: "weight") as? Float)!).")
                }
            }
        }
    }
    
    func YouSure() {
        self.alertController = UIAlertController(title: "Message", message: "Are you sure you want to add this assignment?" , preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (action:UIAlertAction) in
            self.addNewAssignment()
            _ = self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action:UIAlertAction) in
            return
        }
        self.alertController!.addAction(cancelAction)
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
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
            
            // calculate and assign the course average with a new function
            calculateCourseAverage()
            // set the new course average
            //setCourseAverage(course: course!, average: Float(averageForCourse))
            
            print("Percent, Done new average is \(average)")
        } else {
            // DIVIDE THE SUM(SECTION'S GRADES LIST) BY THAT SECTION'S WEIGHT
            var ccGrade = 0.0
            var total = 0
            let cPTotal = course?.value(forKey: "pointstotal") as? Double
            let assignmentList = getAssignmentList(section: selectedSection!)
            for sec in sections! {
                ccGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!) // removed ""
            }
            for ass in assignmentList {
                total += ass.value(forKey: "grade") as! Int
            }
            ccGrade = ccGrade * 2
            
            //1) var average = total/(selectedSection?.value(forKey: "weight") as! Int)
            let weight = selectedSection?.value(forKey: "weight") as! Float
            let average = ((Float(total)/weight) * 100)/2
            setSectionAverage(section: selectedSection!, average: Float(average))
            print("CCGRADE IS HEREEEE")
            print(ccGrade)
            // REPEAT THE ABOVE CODE
            ccGrade = 0.0
            for sec in sections! {
                ccGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!) // removed ""
            }
            ccGrade = ccGrade * 2
            print(ccGrade)
            // set the new course average
            setCourseAverage(course: course!, average: Float(ccGrade))
            
            print("number, new average is \(average)")
        }
    }
    
    func calculateCourseAverage() {
        let cPTotal = course?.value(forKey: "pointstotal") as? Double
        // calculate average for % system
        var currentGrade = 0.0
        if course?.value(forKey: "totalType") as? String == "Percent" {
            for sec in sections! {
                currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/100)
            }
        } else {
            for sec in sections! {
                currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!) // removed ""
            }
        }
        print("NEW COURSE AVERAGE")
        print(currentGrade)
        setCourseAverage(course: course!, average: Float(currentGrade))
        print(currentGrade)
    }
    
    func displayMessage (_message:String){
        
        self.alertController = UIAlertController(title: "Message", message: _message , preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (action:UIAlertAction) in
        }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated: true, completion:nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

