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




class RegistrationViewController: UIViewController {

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
        email = emailRegistor.text!
        userName = userNameRegistor.text!
        passWord = passwordRegistor.text!
        
        if email == nil{
            emailMessage.text = "Email should not be empty!"
        }
        
        if userName == nil{
            userNameMessage.text = "UserName should not be empty!"
        }
        
        if passWord == nil {
            passwordMessage.text = "Password should not be empty!"
        }
    }
    
}
