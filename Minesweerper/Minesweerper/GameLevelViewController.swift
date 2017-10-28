//
//  GameLevelViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 10/26/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GameLevelViewController:UIViewController {
    var level : Int = 0
    var uid : String = ""
    var coins : Int = 0
    var volume : Float = 0.0
    
    @IBAction func ezButton(_ sender: UIButton) {
        level = 0
        goGame()
    }
    
    @IBAction func midButton(_ sender: UIButton) {
        level = 1
        goGame()
    }
    
    @IBAction func hdButton(_ sender: UIButton) {
        level = 2
        goGame()
    }
    
    @IBAction func tdButton(_ sender: UIButton) {
        level = -1
        goGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch user's coins
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async {
            self.uid = (Auth.auth().currentUser?.uid)!
            let ref = Database.database().reference().child("Users").child(self.uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let dictionary = snapshot.value as? [String: AnyObject]
                self.coins = (dictionary?["points"] as? Int)!
            }) { (error) in
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.wait()
    }
    
    func goGame(){
        self.performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            let gameVC: GameViewController = segue.destination as! GameViewController
            gameVC.level = self.level
            gameVC.coins = self.coins
            gameVC.volume = self.volume
        }
        if segue.identifier == "toSettingSegue" {
            let settingVC: GameSettingViewController = segue.destination as! GameSettingViewController
            settingVC.currentV = self.volume
        }
        //print(volume)
    }
}
