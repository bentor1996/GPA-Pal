//
//  AddCourseViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}

class AddCourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var semester: NSManagedObject?
    var semesterID: NSManagedObjectID?
    
    @IBOutlet weak var tableViewSections: UITableView!
    
    @IBOutlet weak var txtClassName: UITextField!
    @IBOutlet weak var segControlTotal: UISegmentedControl!
    @IBOutlet weak var txtTotal: UITextField!
    @IBOutlet weak var txtGradeGoal: UITextField!
    @IBOutlet weak var txtNumSections: UITextField!
    
    var alertController: UIAlertController!
    
    var intRows = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionTableViewCell
        
        cell.lblSectionNumber.text = "Section " + String(indexPath.row + 1)
        //let lastName = candidate.value(forKey: "lastName") as? String
        //cell.detailTextLabel!.text = candidate.value(forKey: "party") as? String
        
        return cell
    }
    
    // this will initally be an empty list of Managed objects
    // This View Controller will need to create a new course object and append it to this list
    var courses: [NSManagedObject]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add New Class"
        self.tableViewSections.dataSource = self
        self.tableViewSections.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        semester = getSemesterWithID(semesterID: semesterID!)
        
        courses = semester?.value(forKey: "courses") as? [NSManagedObject]
        
    }
    
    @IBAction func segControlChange(_ sender: Any) {
        //var segControlChoice = ""
        switch self.segControlTotal.selectedSegmentIndex {
        case 0:
            self.txtTotal.isEnabled = true
            // self.txtTotal.borderStyle = UITextBorderStyleBezel
            self.txtTotal.backgroundColor = UIColor.white
        case 1:
            self.txtTotal.isEnabled = false
           // self.txtTotal.borderStyle = UITextBorderStyleBezel
            self.txtTotal.backgroundColor = UIColor.lightGray
            self.txtTotal.text = ""
        default:
            break
        }
    }
    
    @IBAction func btnPopulateSectionsClicked(_ sender: Any) {
        if (txtGradeGoal.text! != "" || txtNumSections.text! != "" || txtClassName.text! != "" || (txtTotal.text! != "" && segControlTotal.selectedSegmentIndex == 0)){
            if (txtGradeGoal.text!.isNumeric) {
                if (txtNumSections.text!.isNumeric) {
                    if (segControlTotal.selectedSegmentIndex == 0) {
                        if (txtTotal.text!.isNumeric) {
                            if (Int(txtGradeGoal.text!)! <= Int(txtTotal.text!)!){
                            //GOOD
                            intRows = Int(txtNumSections.text!.trimmingCharacters(in: .whitespacesAndNewlines))!
                            self.tableViewSections.reloadData()
                            }
                            else {
                                displayMessage(_message: "Grade goal must be less than or equal to total points")
                            }
                        }
                        else {
                            displayMessage(_message: "Make sure your total points is a whole number")
                        }
                    }
                    else {
                        if (Int(txtGradeGoal.text!)! <= 100) {
                            //GOOD
                            intRows = Int(txtNumSections.text!.trimmingCharacters(in: .whitespacesAndNewlines))!
                            self.tableViewSections.reloadData()
                        }
                        else {
                            displayMessage(_message: "Make sure your grade goal is less than or equal to 100")
                        }
                    }
                }
                else {
                    displayMessage(_message: "Enter a whole number for sections")
                }
            }
            else {
                displayMessage(_message: "Enter a whole number for grade goal")
            }
        }
        else{
            displayMessage(_message: "Fill in all fields")
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
    
    
    
    @IBAction func btnSaveSectionsClicked(_ sender: Any) {
        
        var boolIsGood = true
        var pointsTotal = 0
        for cellNum in 0 ... (intRows - 1) {
            let indexPath = IndexPath(row: cellNum, section: 0)
            guard (tableViewSections.cellForRow(at: indexPath) as! SectionTableViewCell?) != nil
                else {
                    displayMessage(_message: "Fill in all fields")
                    return
            }
            let cell = tableViewSections.cellForRow(at: indexPath) as! SectionTableViewCell
            if (cell.txtName.text != "" && cell.txtWeight.text != ""){
                if (cell.txtWeight.text!.isNumeric) {
                    pointsTotal += Int(cell.txtWeight.text!)!
                }
                else{
                    displayMessage(_message: "Have a whole number for your weight")
                    boolIsGood = false
                }
            }
            else {
                displayMessage(_message: "Fill in all fields")
                boolIsGood = false
            }
        }
        
        if (segControlTotal.selectedSegmentIndex == 0) {
            if (pointsTotal != Int(txtTotal.text!)) {
                displayMessage(_message: "Make sure that your total section points add up to the total specified above")
                return
            }
        }
        else if (segControlTotal.selectedSegmentIndex == 1) {
            if (pointsTotal != 100) {
                displayMessage(_message: "Make sure that your total section points add up to 100")
                return
            }
        }
        
        
        if (boolIsGood){
            
            self.alertController = UIAlertController(title: "Message", message: "Are you sure you want to add this class?" , preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (action:UIAlertAction) in
                //var sections: [NSManagedObject]?
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let entity =  NSEntityDescription.entity(forEntityName: "Course", in: managedContext)
                
                let course = NSManagedObject(entity: entity!, insertInto: managedContext)
                
                for cellNum in 0 ... (self.intRows - 1){
                    let indexPath = IndexPath(row: cellNum, section: 0)
                    let cell = self.tableViewSections.cellForRow(at: indexPath) as! SectionTableViewCell
                    
                    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    //let managedContext = appDelegate.persistentContainer.viewContext
                    
                    // Create the entity we want to save
                    let entity2 =  NSEntityDescription.entity(forEntityName: "Section", in: managedContext)
                    
                    let section = NSManagedObject(entity: entity2!, insertInto: managedContext)
                    
                    // Set the attribute values
                    section.setValue(cell.txtName.text, forKey: "name")
                    section.setValue(Float(cell.txtWeight.text!), forKey: "weight")
                    //section.setValue([NSManagedObject](), forKey: "assignments")
                    course.mutableSetValue(forKey: "sectionList").add(section)
                    
                    // Commit the changes.
                    do {
                        try managedContext.save()
                    } catch {
                        // what to do if an error occurs?
                        let nserror = error as NSError
                        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                        abort()
                    }
                    
                    // Add the new entity to our array of managed objects
                    //sections!.append(section)
                }
                
                //let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                //let managedContext = appDelegate.persistentContainer.viewContext
                
                // Create the entity we want to save
                
                
                // Set the attribute values
                course.setValue(Float(self.txtGradeGoal.text!), forKey: "gradeGoal")
                course.setValue(self.txtClassName.text!, forKey: "name")
                
                if (self.segControlTotal.selectedSegmentIndex == 0){
                    course.setValue("Points", forKey: "totalType")
                    course.setValue(Float(self.txtTotal.text!), forKey: "pointstotal")
                }
                else {
                    course.setValue("Percent", forKey: "totalType")
                    course.setValue(Float(100), forKey: "pointstotal")
                }
                //course.setValue(sections, forKey: "sections")
                
                // Add the new entity to our array of managed objects
                self.courses?.append(course)
                //semester?.setValue(courses, forKey: "courses")
                
                // Commit the changes.
                do {
                    try managedContext.save()
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
                print(course)
                addCourseToSemester(semesterID: self.semesterID!, courseList: course)
                
                
                _ = self.navigationController?.popViewController(animated: true)
                
                
            }
            
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                (action:UIAlertAction) in
                boolIsGood = false
                return
            }
            self.alertController!.addAction(OKAction)
            self.alertController!.addAction(cancelAction)
            self.present(self.alertController!, animated: true, completion:nil)
           
        }
        
        
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
