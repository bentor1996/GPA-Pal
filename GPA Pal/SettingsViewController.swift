//
//  SettingsViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/28/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    private var resources = ResourceList()
    @IBOutlet weak var button: UIButton!
    
    
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
