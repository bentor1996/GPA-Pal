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

class AddCourseViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtClassName: UITextField!
    @IBOutlet weak var segControlTotal: UISegmentedControl!
    @IBOutlet weak var txtTotal: UITextField!
    @IBOutlet weak var txtGradeGoal: UITextField!
    @IBOutlet weak var txtNumSections: UITextField!
    
    var alertController: UIAlertController!
    
    
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
                        }
                        else {
                            displayMessage(_message: "Make sure your total points is a whole number")
                        }
                    }
                    else {
                        //GOOD
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
