//
//  ChangeNameViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 2017/9/21.
//  Copyright © 2017年 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChangeNameViewController: UIViewController {
    
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var userNameMessage: UILabel!
    var uid: String = ""
    var cuser: Users?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("Users").child(self.uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            self.cuser = Users.init(uid: self.uid, dictionary: dictionary!)
        })
    }
    
    @IBAction func SubmitChange(_ sender: UIButton) {
        if userNameCheck() {
            self.cuser?.username = newName.text!
            let ref = Database.database().reference().child("Users").child(self.uid)
            ref.updateChildValues((cuser?.toTable())!)
            self.performSegue(withIdentifier: "changeNameSegue", sender: self)
        }
    }
    
    func userNameCheck() -> Bool {
        
        var result : Bool = false
        //Check if user name is empty
        if newName.text == ""{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "UserName should not be empty!"
        }
            
            //Check length of user name
        else if ((newName.text)?.characters.count)! < 4{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be at least 4 characters"
        }
            
        else if ((newName.text)?.characters.count)! > 15{
            userNameMessage.textColor = UIColor.red
            userNameMessage.text = "User name should be no longer than 15 characters"
        }
            
        else {
            result = true
            userNameMessage.text = ""
        }
        
        return result
    }
}
