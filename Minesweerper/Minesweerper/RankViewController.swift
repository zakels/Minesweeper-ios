//
//  RankViewController.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/27/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
//import Firebase
//import FirebaseDatabase
//import FirebaseAuth




class RankViewController: UIViewController {
    
    
    let rank : Rank = Rank(level: 1)
    var ranks : [String] = ["Abe_98     6666", "BoboBi      6543", "CadyVive        5434", "PandaCyt       4345", "Vivian       2333"]
    
    @IBAction func LevelOneButton(_ sender: UIButton) {
        rank.changeLevel(level: 1)
        loadRanks()
    }
    
    @IBAction func LevelTwoButton(_ sender: UIButton) {
        rank.changeLevel(level: 2)
        loadRanks()
    }
    
    @IBAction func LevelThreeButton(_ sender: UIButton) {
        rank.changeLevel(level: 3)
        loadRanks()
    }
    
    @IBOutlet weak var RankOne: UILabel!
  
    @IBOutlet weak var RankTwo: UILabel!
    
    @IBOutlet weak var RankThree: UILabel!
    
    @IBOutlet weak var RankFour: UILabel!
    
    @IBOutlet weak var RankFive: UILabel!
    
    override func viewDidLoad() {
        loadRanks()
    }
    func loadRanks() {
        //ranks = rank.getTopRanks()
        RankOne.text = ranks[0]
        RankTwo.text = ranks[1]
        RankThree.text = ranks[2]
        RankFour.text = ranks[3]
        RankFive.text = ranks[4]
    }
}
