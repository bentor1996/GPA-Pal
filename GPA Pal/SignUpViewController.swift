//
//  SignUpViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 10/29/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
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
        if (initalPasswordField.text == confirmPasswordField.text) && (initalPasswordField.text != ""){
            return true
        } else {
            return false
        }
    }
    func checkUsername()-> Bool {
        if (usernameField.text != ""){
            return true
        } else {
            return false
        }
    }
    
    @IBAction func createUser(_ sender: Any) {
        if (checkPassword()){
            if checkUsername(){
                // create a user
                Config.setUsername(usernameField.text!)
                Config.setPassword(confirmPasswordField.text!)
                warningMessage.text = "New account created!"
                self.warningMessage.isHidden = false
            } else {
                warningMessage.text = "Please create a username"
                self.warningMessage.isHidden = false
            }
            
            
        } else{
            // change label and make them do it again
            warningMessage.text = "Passwords do not match, please try again"
            self.warningMessage.isHidden = false
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
    }
    */

}
