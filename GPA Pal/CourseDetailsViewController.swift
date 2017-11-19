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
    @IBAction func addGradeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddNewGrade", sender: self)
    }
    @IBAction func goalReachButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toGoalReacher", sender: self)
    }
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var sectionType: UILabel!
    @IBOutlet weak var sectionGrade: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var course: NSManagedObject?
    var courseID: NSManagedObjectID?
    var sections: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
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
        print(sections!)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionListTableViewCell
        let section = sections![indexPath.row]
        let name = section.value(forKey: "name") as? String
        let grade = section.value(forKey: "grade") as? Float
        cell.sectionType!.text = name
        if grade == nil {
            cell.sectionGrade!.text = "0"
        } else {
            cell.sectionGrade!.text = String(describing: grade!)
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
                //cvc.semester = semesters[(selectedIndex?.row)!]
                avc.semesterID = semesters![(selectedIndex?.row)!].objectID
                //avc.courseID = courseID!
            }
        }
        if segue.identifier == "toAddNewGrade"{
            if let avc = segue.destination as? AddNewGradeViewController {
                let selectedIndex = tableView.indexPathForSelectedRow
                //cvc.semester = semesters[(selectedIndex?.row)!]
                avc.semesterID = semesters![(selectedIndex?.row)!].objectID
                //avc.courseID = courseID!
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    

}
