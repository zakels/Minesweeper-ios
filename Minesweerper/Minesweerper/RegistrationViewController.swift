//
//  RegistrationViewController.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/16/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth




class RegistrationViewController: UIViewController, UITextFieldDelegate {

    var email : String = ""
    var userName : String = ""
    var passWord : String = ""
    var repeatPassword : String = ""
    
    @IBOutlet weak var emailRegistor: UITextField!
    @IBOutlet weak var emailMessage: UILabel!
    
    @IBOutlet weak var userNameRegistor: UITextField!
    @IBOutlet weak var userNameMessage: UILabel!
    
    @IBOutlet weak var passwordRegistor: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    
    
    @IBOutlet weak var repeatRegistor: UITextField!
    @IBOutlet weak var repeatMessage: UILabel!
    
    @IBAction func RegistButton(_ sender: UIButton) {
        
        email = emailRegistor.text!
        userName = userNameRegistor.text!
        passWord = passwordRegistor.text!
        repeatPassword = repeatRegistor.text!
        
        if isValid() {
            Auth.auth().createUser(withEmail: email, password: passWord) {(user, error) in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.email, password: self.passWord)
                    let newUser = Users(email: self.email, username: self.userName, password: self.passWord, uid: (user?.uid)!)
                    let rootRef = Database.database().reference(withPath: "Users")
                    let userRef = rootRef.child((user?.uid)!)
                    userRef.setValue(newUser.toAnyObject())
                    self.performSegue(withIdentifier: "RegisterSegue", sender: self)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
            }
        }
        
    }
    
    func isValid() -> Bool {
        var emailValid : Bool = false
        var userNameValid : Bool = false
        var passwordValid : Bool = false
        var repeatValid : Bool = false
        
        emailValid = emailCheck()
        userNameValid = userNameCheck()
        passwordValid = passwordCheck()
        repeatValid = repeatCheck()
        
        return emailValid && userNameValid && passwordValid && repeatValid
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func emailCheck() -> Bool {
        
        var result : Bool = false
        //Check if email is empty
        
        if email == ""{
            emailMessage.textColor = UIColor.red
            emailMessage.text = "Email should not be empty!"
        }
        
        //Check if email is valid
        else if !isValidEmail(testStr: email){
            emailMessage.textColor = UIColor.red
            emailMessage.text = "Please input a valid email"
        }
        
        else{
            emailMessage.text = ""
            result = true
        }
       
        return result
    }
    
    //
    func userNameCheck() -> Bool {
        
        var result : Bool = false
        //Check if user name is empty
        if userName == ""{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "UserName should not be empty!"
        }
        
        //Check length of user name
        else if userName.characters.count < 4{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be at least 4 characters"
        }
        
        else if userName.characters.count > 15{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be no longer than 15 characters"
        }

        else {
            result = true
            userNameMessage.text = ""
        }
        
        return result
    }
    
    func passwordCheck() -> Bool {
        
        var result : Bool = false
        //Check if passWord is empty
        if passWord == "" {
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should not be empty!"
        }
        
        //Check length of passWord
        else if passWord.characters.count < 6{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should be at least 6 characters"
        }
        
        else if passWord.characters.count > 16{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should be no longer than 16 characters"
        }
        
        else {
            passwordMessage.text = ""
            result = true
        }
        
        return result
        
    }
    
    func repeatCheck() -> Bool {
        if passWord == repeatPassword {
            repeatMessage.text = ""
            return true
        }
        
        else{
            repeatMessage.textColor = UIColor.red
            repeatMessage.text = "Not match with password"
            return false
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
