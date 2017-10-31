//
//  SignUpViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var initalPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var warningMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.warningMessage.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkPassword()-> Bool {
        if (initalPasswordField.text == confirmPasswordField.text){
            return true
        } else {
            return false
        }
    }
    
    @IBAction func createUser(_ sender: Any) {
        if (checkPassword()){
            // create a user
            Config.setPassword(confirmPasswordField.text!)
            warningMessage.text = "New account created!"
            self.warningMessage.isHidden = false
            
        } else{
            // change label and make them do it again
            warningMessage.text = "Passwords do not match, please try again"
            self.warningMessage.isHidden = false
        }
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
