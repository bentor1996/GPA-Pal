//
//  SettingsViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/28/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var resources = ResourceList()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataModelObjects()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count()
    }
    
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let resource = resources.getResource(index: indexPath.row)
        cell.textLabel?.text = resource.name
        cell.detailTextLabel?.text = resource.number
        return cell
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
