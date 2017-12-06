//
//  SettingsViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/28/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    private var resources = ResourceList()
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    var alertController1: UIAlertController!
    var alertController2: UIAlertController!
    var alertController3: UIAlertController!
    
    override func viewDidLoad() {
        createDataModelObjects()
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        button.backgroundColor = .white
        button.layer.cornerRadius = 37.5
        button.layer.borderWidth = 1
        //button.layer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5);
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderColor = UIColor.clear.cgColor
        btnDelete.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func createDataModelObjects() {
        resources.addResource(name: "Crisis Line", number: "512-471-CALL")
        resources.addResource(name: "Care Counselor", number: "512-475-3515")
        resources.addResource(name: "Sanger Learning Center", number: "512-471-3614")
        resources.addResource(name: "Undergraduate Writing Center", number: "512-471-6222")
        resources.addResource(name: "Vick Center for Advising", number: "512-232-8400")
    }
    @IBAction func btnClicked(_ sender: Any) {
    //_ = self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func resetData(_ sender: Any) {
        self.alertController1 = UIAlertController(title: "Are you sure you want to delete all data??", message:"", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (action:UIAlertAction) in
            //var sections: [NSManagedObject]?
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let fetch1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Semester")
            let fetch2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
            let fetch3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Section")
            let fetch4 = NSFetchRequest<NSFetchRequestResult>(entityName: "Assignment")
            let request1 = NSBatchDeleteRequest(fetchRequest: fetch1)
            let request2 = NSBatchDeleteRequest(fetchRequest: fetch2)
            let request3 = NSBatchDeleteRequest(fetchRequest: fetch3)
            let request4 = NSBatchDeleteRequest(fetchRequest: fetch4)
            let result1 = try? managedObjectContext.execute(request1)
            let result2 = try? managedObjectContext.execute(request2)
            let result3 = try? managedObjectContext.execute(request3)
            let result4 = try? managedObjectContext.execute(request4)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            self.alertController2 = UIAlertController(title: "All data has been successfully deleted!", message:"", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction2 = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (action:UIAlertAction) in
            }
            self.alertController2!.addAction(OKAction2)
            self.present(self.alertController2!, animated: true, completion:nil)
                // Add the new entity to our array of managed objects
                //sections!.append(section)
            
        }

        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action:UIAlertAction) in
            return
        }
    
        self.alertController1!.addAction(cancelAction)
        self.alertController1!.addAction(OKAction)
        
        self.present(self.alertController1!, animated: true, completion:nil)
        
    }
        

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count()
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let resource = resources.getResource(index: indexPath.row)
        cell.textLabel?.text = resource.name
        //cell.detailTextLabel?.text = resource.number
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the index path of selected row
        //let indexPath = tableView.indexPathForSelectedRow
        let resource = resources.getResource(index: (indexPath.row))
        //getting the current cell from the index path
        //let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as UITableViewCell
        
        //getting the text of that cell
        //let currentItem = currentCell.textLabel!.text
        
        self.alertController3 = UIAlertController(title: resource.name, message: resource.number , preferredStyle: UIAlertControllerStyle.alert)
        let OKAction3 = UIAlertAction(title: "Close", style: UIAlertActionStyle.default) {
            (action:UIAlertAction) in
        }
        self.alertController3.addAction(OKAction3)
        
        self.present(self.alertController3!, animated: true, completion:nil)
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
