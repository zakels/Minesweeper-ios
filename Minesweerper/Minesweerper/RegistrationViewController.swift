//
//  RegistrationViewController.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/16/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth




class RegistrationViewController: UIViewController, UITextFieldDelegate {

    var email : String = ""
    var userName : String = ""
    var passWord : String = ""
    
    
    @IBOutlet weak var emailRegistor: UITextField!
    @IBOutlet weak var emailMessage: UILabel!
    
    @IBOutlet weak var userNameRegistor: UITextField!
    @IBOutlet weak var userNameMessage: UILabel!
    
    @IBOutlet weak var passwordRegistor: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    
    @IBAction func RegistButton(_ sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        emailRegistor.addTarget(self, action: #selector(emailFieldDidChange(textField:)), for: UIControlEvents.editingDidEnd)
        userNameRegistor.addTarget(self, action: #selector(userNameFieldDidChange(textField:)), for:  UIControlEvents.editingChanged)
        passwordRegistor.addTarget(self, action: #selector(passwordFieldDidChange(textField:)), for:  UIControlEvents.editingChanged)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func emailFieldDidChange(textField: UITextField){
        
        //Check if email is empty
        if email == ""{
            emailMessage.textColor = UIColor.red
            emailMessage.text = "Email should not be empty!"
        }
        
        //Check if email is valid
        if !isValidEmail(testStr: email){
            emailMessage.textColor = UIColor.red
            emailMessage.text = "Please input a valid email"
        }else{
            
            emailMessage.text = ""
        }
       

    }
    
    //
    func userNameFieldDidChange(textField: UITextField){
        
        //Check if user name is empty
        if userName == ""{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "UserName should not be empty!"
        }
        
        //Check length of user name
        if userName.characters.count < 4{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be at least 4 characters"
        }
        
        if userName.characters.count > 15{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be no longer than 15 characters"
        }

        if userName.characters.count >= 4 && userName.characters.count <= 15{
            userNameMessage.text = ""
        }
    }
    
    func passwordFieldDidChange(textField: UITextField){
        
        //Check if passWord is empty
        if passWord == "" {
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should not be empty!"
        }
        
        //Check length of passWord
        if passWord.characters.count < 6{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should be at least 6 characters"
        }
        
        if passWord.characters.count > 16{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should be no longer than 16 characters"
        }
        
        if passWord.characters.count >= 6 && passWord.characters.count <= 16 {
            passwordMessage.text = ""
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
