//
//  CourseDetailsViewController.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/14/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class CourseDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var settingsBtn: UIImageView!
    @IBOutlet weak var btnGoalInsight: UIButton!
    
    /*@IBAction func addGradeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddNewGrade", sender: self)
    }*/
    @IBAction func goalReachButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toGoalReacher", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var course: NSManagedObject?
    var tempcourse: NSManagedObject?
    var courseID: NSManagedObjectID?
    var sections: [NSManagedObject]?
    var sectionID: NSManagedObjectID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        settingsBtn.image = UIImage(named: "settings")
        tempcourse = getCourseWithID(courseID: courseID!)
        //self.goalLabel.text = getCourseGoal(course: tempcourse!)
        let gradeGoal = self.tempcourse?.value(forKey: "gradeGoal")
        self.goalLabel.text =  String(describing: gradeGoal!)
        print(tempcourse!)
        btnGoalInsight.layer.cornerRadius = 15
        //print(self.tempcourse?.value(forKey: "gradeGoal") as? String!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        course = getCourseWithID(courseID: courseID!)
        self.title = course?.value(forKey: "name") as? String
        self.sections = getSectionList(course: course!)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! CourseDetailsTableViewCell
        let section = sections![indexPath.row]
        let name = section.value(forKey: "name") as? String
        let grade = section.value(forKey: "average") as? Float
        let weight = section.value(forKey: "weight") as? Float
        cell.sectionType!.text = name
        if course?.value(forKey: "totalType") as? String == "Percent"{
            if grade == nil {
                cell.sectionGrade!.text = "0%"
            } else {
                var strtext = ""
                strtext += String(grade!)
                strtext += "%"
                cell.sectionGrade!.text = strtext
            }
        } else {
            if grade == nil {
                var strtext = ""
                strtext += "0.0/"
                strtext += String(describing: weight!)
                cell.sectionGrade!.text = strtext
            } else {
                var strtext = ""
                strtext += String(describing: ((grade!/100) * weight! * 2))
                strtext += "/"
                strtext += String(describing: weight!)
                cell.sectionGrade!.text = strtext
            }
        }
        
        return cell
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSectionTableView"{
            if let avc = segue.destination as? SectionTableViewController {
                let selectedIndex = tableView.indexPathForSelectedRow
                avc.sectionID = sections![(selectedIndex?.row)!].objectID
            }
        }
        if segue.identifier == "toAddNewGrade"{
            if let angvc = segue.destination as? AddNewGradeViewController {
                //let selectedIndex = tableView.indexPathForSelectedRow
                //cvc.semester = semesters[(selectedIndex?.row)!]
                angvc.courseID = courseID
                //avc.courseID = courseID!
            }
        }
        
        if segue.identifier == "toGoalReacher"{
            if let grvc = segue.destination as? GoalReacherViewController {
                grvc.courseID = courseID
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
    
    @IBAction func settingsClicked(_ sender: Any) {

        performSegue(withIdentifier: "toSettings3", sender: nil)
    }
    
}
