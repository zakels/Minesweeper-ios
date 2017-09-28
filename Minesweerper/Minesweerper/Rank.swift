//
//  Rank.swift
//  Minesweerper
//
//  Created by Wenya Zhu on 9/20/17.
//  Copyright © 2017 Dan Luo. All rights reserved.
//
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

public class Rank {
    
    var level : Int = 0
    
    init(level: Int){
        self.level = level
    }
    
    func changeLevel(level: Int) {
        self.level = level
    }
    
    func getTopRanks() -> [String]{
        let str = "level" + String(level)
        var strs : [String] = []
        var ref : DatabaseReference!
        ref = Database.database().reference().child("Ranks").child(str)
        let query = ref.queryOrdered(byChild: "points").queryLimited(toLast: 5)
        
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            print(dictionary ?? "DICTIONARY ERROR")
            let uid = dictionary?["uid"]
            var userName : String = ""
            let userRef = Database.database().reference().child("Users").child(uid as! String)
            userRef.observeSingleEvent(of: .value, with: {(snap) in
                let dict = snap.value as? [String: AnyObject]
                userName = (dict?["username"])! as! String
            })
            
            let points = dictionary?["points"]
            strs.append(userName + String(describing: points))
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return strs
    }
    
}
