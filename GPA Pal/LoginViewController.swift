//
//  LoginViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnUp: UIButton!
    @IBOutlet weak var warningMessage: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.warningMessage.isHidden = true
        btnIn.layer.cornerRadius = 15
        btnUp.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "username")==nil || (UserDefaults.standard.object(forKey: "password")==nil)){
            warningMessage.text = "Please sign up to make an account with GPA Pal"
            self.warningMessage.isHidden = false
        } else{
            if UserDefaults.standard.object(forKey: "username") == nil{
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }*/
    

}
