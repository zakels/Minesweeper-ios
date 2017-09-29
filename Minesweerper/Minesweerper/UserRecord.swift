//
//  Record.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/20/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

public class userRecord {
    var uid : String = ""
    var points : Int = 0
    var userName : String = ""
    var level : Int = 0
    var size : Int = 0
    var levelStr : String = ""
    
    init(level: Int, points: Int) {
        self.uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("Users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            self.userName = (dictionary?["username"] as? String)!
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.level = level
        self.points = points
        
        self.levelStr = "Level" + String(self.level)
        
    }
    
    func creatRecord(){
       
        let ref = Database.database().reference().child("Records").child(self.levelStr)
        
        getSize(){ () -> () in
            print("TEST:")
            print(size)
            
            let rankStr : String = "Record" + String(size + 1)
            let recordRef = ref.child(rankStr)
            
            
            recordRef.setValue(["user": self.uid, "points": self.points])
        }
        
    }
    
    func getSize(handleComplete:(()->())){
        let ref = Database.database().reference().child("Records").child(self.levelStr)
        
        print(ref)
        
        ref.observe(.value, with: { snapshot in
            if snapshot.exists(){
                self.size = Int(snapshot.childrenCount.description)!
                print(self.size)
            }
            
        })
        handleComplete()
    }
}
