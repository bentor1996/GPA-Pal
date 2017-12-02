//
//  SettingsViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/28/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        button.backgroundColor = .white
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 1
        //button.layer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5);
        button.layer.borderColor = UIColor.clear.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClicked(_ sender: Any) {
    //_ = self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.isNavigationBarHidden = false
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
