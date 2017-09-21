//
//  profileViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 2017/9/20.
//  Copyright © 2017年 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class profileViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var points: UILabel!
    
    var uid: String = ""
    var CurrentUser: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = Auth.auth().currentUser
        if(currentUser != nil) {
            uid = (currentUser?.uid)!
        }
        let rootref = Database.database().reference(withPath: "Users")
        let userref = rootref.child(self.uid)
        
        userref.observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? [String: AnyObject]
            self.CurrentUser = Users.init(uid: self.uid, dictionary: value!)
            self.username.text = self.CurrentUser?.username
            self.points.text = String((self.CurrentUser?.points)!)
        })
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let authUser = Auth.auth()
        do {
            try authUser.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
}
