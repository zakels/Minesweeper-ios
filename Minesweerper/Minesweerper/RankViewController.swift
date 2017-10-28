//
//  RankViewController.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/27/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth




class RankViewController: UIViewController {
    
    
    var level : Int = 0
    var ranks : [rank] = []

    
    @IBAction func LevelOneButton(_ sender: UIButton) {
        
        self.level = 1
        
        
        loadRanks()
    }
    
    @IBAction func LevelTwoButton(_ sender: UIButton) {
        
        self.level = 2
        loadRanks()
    }
    
    @IBAction func LevelThreeButton(_ sender: UIButton) {
        
        self.level = 3
        loadRanks()
    }
    
    @IBOutlet weak var RankOne: UILabel!
  
    @IBOutlet weak var RankTwo: UILabel!
    
    @IBOutlet weak var RankThree: UILabel!
    
    @IBOutlet weak var RankFour: UILabel!
    
    @IBOutlet weak var RankFive: UILabel!
    
    override func viewDidLoad() {
        self.level = 1
        loadRanks()
    }
    
    
    func loadRanks() {

        var count : Int = 0
        ranks = []
        let ref = Database.database().reference(withPath: "Ranks").child("Level"+String(self.level))
        ref.queryOrdered(byChild: "scores").queryLimited(toLast: 5).observe(DataEventType.value, with: {(snapshot) in
//            print("INTO")
//        })
//        ref.observe(DataEventType.value, with: {(snapshot) in
            
            for child in snapshot.children{
                
                let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key)
                let dictionary = (childSnapshot.value as? NSDictionary)!
                let uid = (dictionary["user"] as? String)!
                let score = (dictionary["scores"] as? Int)!
                let ref2 = Database.database().reference().child("Users").child(uid)
                
                
                ref2.observe(DataEventType.value, with: {(snapshot2) in
                    count = count + 1
                    
                    let dictionary2 = (snapshot2.value as? NSDictionary)!
                    let username = (dictionary2["username"] as? String)!
                    let r = rank(user: uid, score: score, userName: username)
                    self.ranks.append(r)
                    
                    if count == 1 {
                        self.RankFive.text = self.ranks[0].userName + " " + String(self.ranks[0].score)
                        
                    }else if count == 2{
                        self.RankFour.text = self.ranks[1].userName + " " + String(self.ranks[1].score)
                    }else if count == 3{
                        self.RankThree.text = self.ranks[2].userName + " " + String(self.ranks[2].score)
                    }else if count == 4{
                        self.RankTwo.text = self.ranks[3].userName + " " + String(self.ranks[3].score)
                    }else if count == 5{
                        self.RankOne.text = self.ranks[4].userName + " " + String(self.ranks[4].score)
                    }
                    
                }){ (error) in
                    print(error.localizedDescription)
                }
            }
            
        })
        
       
        
//                RankTwo.text = ranks[1].userName + " " + String(ranks[1].score)
//        RankThree.text = ranks[2].userName + " " + String(ranks[2].score)
//        RankFour.text = ranks[3].userName + " " + String(ranks[3].score)
//        RankFive.text = ranks[4].userName + " " + String(ranks[4].score)

    }
    

    
}
