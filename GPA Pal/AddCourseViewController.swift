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

class AddCourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
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
    var courses = [NSManagedObject]()

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
                        
                        if (txtTotal.text!.isNumeric){
                            //GOOD
                            intRows = Int(txtNumSections.text!.trimmingCharacters(in: .whitespacesAndNewlines))!
                            self.tableViewSections.reloadData()
                        }
                        else {
                            displayMessage(_message: "Make sure your total points is a whole number")
                        }
                    }
                    else {
                        //GOOD
                        intRows = Int(txtNumSections.text!.trimmingCharacters(in: .whitespacesAndNewlines))!
                        self.tableViewSections.reloadData()
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
        for cellNum in 0 ... intRows {
            let indexPath = IndexPath(row: cellNum, section: 0)
            let cell = tableViewSections.cellForRow(at: indexPath) as! SectionTableViewCell
            if (cell.txtName.text != "" || cell.txtWeight.text != ""){
                if (cell.txtWeight.text!.isNumeric) {

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
        
        
        
        if (boolIsGood){
            var sections = [NSManagedObject]()
            for cellNum in 0 ... intRows {
                let indexPath = IndexPath(row: cellNum, section: 0)
                let cell = tableViewSections.cellForRow(at: indexPath) as! SectionTableViewCell
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let managedContext = appDelegate.persistentContainer.viewContext
                
                // Create the entity we want to save
                let entity =  NSEntityDescription.entity(forEntityName: "Section", in: managedContext)
                
                let section = NSManagedObject(entity: entity!, insertInto: managedContext)
                
                // Set the attribute values
                section.setValue(cell.txttext, forKey: "name")
                section.setValue([NSManagedObject](), forKey: "courses")
                
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
                semesters.append(semester)
                
                
                
                
                
            }
        }
        
        
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
