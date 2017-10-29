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
    
    
    @IBOutlet weak var emailImage: UIImageView!
    
    @IBOutlet weak var userNameImage: UIImageView!
    
    @IBOutlet weak var passwordImage: UIImageView!
    
    @IBOutlet weak var repeatImage: UIImageView!
    
    @IBOutlet weak var emailRegistor: UITextField!
    @IBOutlet weak var emailMessage: UILabel!
    
    @IBOutlet weak var userNameRegistor: UITextField!
    @IBOutlet weak var userNameMessage: UILabel!
    
    @IBOutlet weak var passwordRegistor: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    
    
    @IBOutlet weak var repeatRegistor: UITextField!
    @IBOutlet weak var repeatMessage: UILabel!
    
    override func viewDidLoad() {
        self.emailRegistor.delegate = self
        self.userNameRegistor.delegate = self
        self.passwordRegistor.delegate = self
        self.repeatRegistor.delegate = self
    }
    
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
            emailMessage.text = "Should not be empty!"
            emailImage.image = UIImage(named: "wrong.png")
        }
            
            //Check if email is valid
        else if !isValidEmail(testStr: email){
            emailMessage.textColor = UIColor.red
            emailMessage.text = "Invalid email"
            emailImage.image = UIImage(named: "wrong.png")
        }
            
        else{
            emailMessage.text = ""
            emailImage.image = UIImage(named: "correct.png")
            result = true
        }
        
        emailMessage.sizeToFit()
        return result
    }
    
    //
    func userNameCheck() -> Bool {
        
        var result : Bool = false
        //Check if user name is empty
        if userName == ""{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "Should not be empty!"
            userNameImage.image = UIImage(named: "wrong.png")
        }
            
            //Check length of user name
        else if userName.characters.count < 4{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "At least 4 characters"
            userNameImage.image = UIImage(named: "wrong.png")
        }
            
        else if userName.characters.count > 15{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "No longer than 15 characters"
            userNameImage.image = UIImage(named: "wrong.png")
        }
            
        else {
            result = true
            userNameMessage.text = ""
            userNameImage.image = UIImage(named: "correct.png")
            
        }
        userNameMessage.sizeToFit()
        
        return result
    }
    
    func passwordCheck() -> Bool {
        
        var result : Bool = false
        //Check if passWord is empty
        if passWord == "" {
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Should not be empty!"
            passwordImage.image = UIImage(named: "wrong.png")
        }
            
            //Check length of passWord
        else if passWord.characters.count < 6{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "At least 6 characters"
            passwordImage.image = UIImage(named: "wrong.png")
        }
            
        else if passWord.characters.count > 16{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "No longer than 16 characters"
            passwordImage.image = UIImage(named: "wrong.png")
        }
            
        else {
            passwordMessage.text = ""
            result = true
            passwordImage.image = UIImage(named: "correct.png")
        }
        
        passwordMessage.sizeToFit()
        return result
        
    }
    
    func repeatCheck() -> Bool {
        var result : Bool = false
        if repeatPassword == ""{
            repeatMessage.text = "Should not be empty!"
            repeatImage.image = UIImage(named: "wrong.png")
        }
        else if passWord == repeatPassword {
            repeatMessage.text = ""
            repeatImage.image = UIImage(named: "correct.png")
            result = true
        }
            
        else{
            repeatMessage.text = "Not match with password"
            repeatImage.image = UIImage(named: "wrong.png")
        }
        
        repeatMessage.textColor = UIColor.red
        repeatMessage.sizeToFit()
        return result
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailRegistor.resignFirstResponder()
        self.userNameRegistor.resignFirstResponder()
        self.passwordRegistor.resignFirstResponder()
        self.repeatRegistor.resignFirstResponder()
        return true
    }
    
    
    
    
}
