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
    
    var Users : [String] = []
    var Points : [Int] = []
    
    
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
        self.size = 0
        
    }
    
    func creatRecord(){
        let ref = Database.database().reference(withPath: "Records").child("Level"+String(self.level))
        ref.childByAutoId().setValue(["user": self.uid, "scores": self.points])
    }
    
    func getSize() -> Int{

        var count : Int = 0
        
        let ref = Database.database().reference(withPath: "Records")
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            count = Int(snapshot.childrenCount.description)!
        })
        
        return count
    }
    
    func compTop(){

        
        
    }
}
