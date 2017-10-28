//
//  GameLevelViewController.swift
//  Minesweerper
//
//  Created by Dan Luo on 10/26/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit

class GameLevelViewController:UIViewController {
    var level : Int = 0
    
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
    
    func goGame(){
        self.performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            let gameVC: GameViewController = segue.destination as! GameViewController
            gameVC.level = self.level
        }
    }
}
