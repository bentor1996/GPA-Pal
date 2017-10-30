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
    
    var semester = NSManagedObject()
    var courses = [NSManagedObject]()

    @IBOutlet weak var settingsBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courses"
        settingsBtn.image = UIImage(named: "settings")
        print(semester)
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
        
        self.courses = semester.value(forKey: "courses") as! [NSManagedObject]
        self.tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        
        let course = courses[indexPath.row]
        let name = course.value(forKey: "name") as? String
        let grade = course.value(forKey: "grade") as? Float
        
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = String(describing: grade)
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toAddClass" {
            if let avc = segue.destination as? AddCourseViewController {
                avc.courses = self.courses
            }
        }
        // Pass the selected object to the new view controller.
    }
    

}
