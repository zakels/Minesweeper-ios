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

public class Record {
    var uid : String = ""
    var points : Int = 0
    var userName : String = ""
    var level : Int = 0
    
    init(level: Int, points: Int) {
        self.uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("Users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            self.userName = (dictionary?["username"] as? String)!
            
        }) { (error) in
                print(error.localizedDescription)
        }
        
    }
    
    func creatRecord(record: Record){
        var size : Int = 0
        
        let level = "Level" + String(record.level)
        let ref = Database.database().reference().child("Ranks").child(level)
        ref.observe(.value, with: { snapshot in
            for _ in snapshot.children{
                size += 1
            }
        })
        
        let rankStr : String = "Rank" + String(size + 1)
        let recordRef = ref.child(rankStr)
        recordRef.setValue(["uid": record.uid])
        recordRef.setValue(["points": record.points])
        
    }
    
}
