//
//  SemestersViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class SemestersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var newSemesterPop: UIAlertController? = nil
    var semesterName: UITextField? = nil
    var semesters: [NSManagedObject]?

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var settingsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Semesters"
        settingsImage.image = UIImage(named: "settings")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.setHidesBackButton(true, animated:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        semesters = getAllSemesters()
        
        
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Semester")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            semesters = results
        } else {
            print("Could not fetch")
        }*/
    }
    
    @IBAction func addNewSemester(_ sender: Any) {
        self.newSemesterPop = UIAlertController(title: "Add New Semester", message: "What Semester would you like to add?", preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            // add new semester
            self.addSemester()
            self.tableView.reloadData()
            print("User created a semester")
            //print("You entered \(self.loginTextField!.text!)")
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            print("User did not sumbit a semester")
        }
        
        self.newSemesterPop!.addAction(ok)
        self.newSemesterPop!.addAction(cancel)
        
        self.newSemesterPop!.addTextField { (textField) -> Void in
            // Enter the textfield customization code here.
            self.semesterName = textField
            self.semesterName?.placeholder = "Type Here"
        }
        
        present(self.newSemesterPop!, animated: true, completion: nil)
    }
    
    func addSemester() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Semester", in: managedContext)
        
        let semester = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        semester.setValue(semesterName?.text, forKey: "name")
        //semester.setValue([NSManagedObject](), forKey: "courses")
        
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
        semesters?.append(semester)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.semesters!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "semesterCell", for: indexPath) as! SemestersTableViewCell
        
        let semester = semesters![indexPath.row]
        let name = semester.value(forKey: "name") as? String
        //let lastName = candidate.value(forKey: "lastName") as? String
        cell.semesterName!.text = name
        //cell.detailTextLabel!.text = candidate.value(forKey: "party") as? String
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAllClass" {
            if let cvc = segue.destination as? CourseViewController {
                let selectedIndex = tableView.indexPathForSelectedRow
                //cvc.semester = semesters[(selectedIndex?.row)!]
                cvc.semesterID = semesters![(selectedIndex?.row)!].objectID
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
}
