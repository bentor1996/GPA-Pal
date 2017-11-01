//
//  LoginViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var warningMessage: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.warningMessage.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        if (Config.password()==nil || (Config.username()==nil)){
            warningMessage.text = "Please sign up to make an account with GPA Pal"
            self.warningMessage.isHidden = false
        } else{
            if Config.username() == nil{
                warningMessage.text = "Please sign up to make an account with GPA Pal"
                self.warningMessage.isHidden = false
            } else{
                if(usernameField.text == Config.username()){
                    if(password.text == Config.password()){
                        self.performSegue(withIdentifier: "toSemesters", sender: self)
                    } else {
                        warningMessage.text = "Please enter the correct password"
                        self.warningMessage.isHidden = false
                    }
                } else {
                    warningMessage.text = "Please enter the correct username"
                    self.warningMessage.isHidden = false
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }*/
    

}
