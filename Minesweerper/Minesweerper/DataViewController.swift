//
//  DataViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 2017/9/7.
//  Copyright © 2017年 Dan Luo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var dataObject: String = ""

    @IBAction func loginToMain(_ sender: UIButton) {
        let email = usernameField.text
        let password = passwordField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            } else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil);
            }
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.usernameField.delegate = self
        self.passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel.text = dataObject
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }
}

