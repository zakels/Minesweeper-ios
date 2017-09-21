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
        self.cuser?.username = newName.text!
        let ref = Database.database().reference().child("Users").child(self.uid)
        ref.updateChildValues((cuser?.toTable())!)
        self.performSegue(withIdentifier: "changeNameSegue", sender: self)
    }
}
