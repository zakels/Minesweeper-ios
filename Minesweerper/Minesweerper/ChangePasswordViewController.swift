//
//  ChangePasswordViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 2017/9/21.
//  Copyright © 2017年 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    @IBOutlet weak var repeatMessage: UILabel!
    
    var uid: String = ""
    var cuser: Users?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("Users").child(self.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            self.cuser = Users.init(uid: self.uid, dictionary: dictionary!)
        })
    }
    
    @IBAction func submitChange(_ sender: UIButton) {
        var valid: Bool = true
        if !passwordCheck() {
            valid = false
        }
        if !repeatCheck() {
            valid = false
        }
        
        if valid == true {
            let credencial = EmailAuthProvider.credential(withEmail: (cuser?.email)!, password: (cuser?.password)!)
            let user = Auth.auth().currentUser
            user?.reauthenticate(with: credencial, completion: { (error) in
                if error == nil {
                    self.cuser?.password = self.repeatPassword.text!
                    user?.updatePassword(to: (self.cuser?.password)!)
                    let ref = Database.database().reference().child("Users").child(self.uid)
                    ref.updateChildValues((self.cuser?.toTable())!)
                    self.performSegue(withIdentifier: "ChangePasswordSegue", sender: self)
                }
                
            })
        }
    }
    
    func passwordCheck() -> Bool {
        
        var result : Bool = false
        //Check if passWord is empty
        if newPassword.text == "" {
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should not be empty!"
        }
            
            //Check length of passWord
        else if (newPassword.text?.characters.count)! < 6{
            passwordMessage.textColor = UIColor.red
            passwordMessage.text = "Password should be at least 6 characters"
        }
            
        else if (newPassword.text?.characters.count)! > 16{
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
        if newPassword.text == repeatPassword.text {
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
