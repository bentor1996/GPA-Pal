//
//  CourseViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class CourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var semester: NSManagedObject?
    var semesterID: NSManagedObjectID?
    var courses: [NSManagedObject]?
    var courseID: NSManagedObjectID?

    @IBOutlet weak var settingsBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = semester.value(forKey: "name") as? String
        settingsBtn.image = UIImage(named: "settings")
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
        
        semester = getSemesterWithID(semesterID: semesterID!)
        self.title = semester?.value(forKey: "name") as? String
        
        //self.courses = semester?.value(forKey: "courses") as? [NSManagedObject]
        self.courses = getCourseList(semester: semester!)
        print(courses!)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseListTableViewCell
        
        let course = courses![indexPath.row]
        let name = course.value(forKey: "name") as? String
        let grade = course.value(forKey: "grade") as? Float
        
        cell.courseName!.text = name
        if grade == nil {
            cell.courseGrade!.text = "0"
        } else {
            cell.courseGrade!.text = String(describing: grade!)+"%"
        }
        
        //cell.detailTextLabel!.text = String(describing: grade)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toAddClass" {
            if let avc = segue.destination as? AddCourseViewController {
                //avc.semester = semester
                avc.semesterID = semesterID!
                //avc.courses = semester.value(forKey: "courses") as! [NSManagedObject]
            }
        } else if segue.identifier == "toCourseDetailsView" {
            if let cdvc = segue.destination as? CourseDetailsViewController {
                let selectedIndex = tableView.indexPathForSelectedRow
                print(courses![(selectedIndex?.row)!].objectID)
                cdvc.courseID = courses![(selectedIndex?.row)!].objectID
                //avc.courseID = courseID!
            }
        } else if segue.identifier == "toGraph" {
            if let gvc = segue.destination as? GraphViewController {
                //avc.semester = semester
                gvc.semesterID = semesterID!
                //avc.courses = semester.value(forKey: "courses") as! [NSManagedObject]
            }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        // Pass the selected object to the new view controller.
        }
    }
}
