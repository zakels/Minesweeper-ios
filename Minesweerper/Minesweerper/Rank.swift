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

public struct rank {
    var user : String
    var score : Int
}

public class Rank {
    
    
    var level : Int = 0
    
    init(level: Int){
        self.level = level
    }
    
    func changeLevel(level : Int){
        self.level = level
    }
    
    func getTopRanks() -> [rank]{

        var ranks = [rank]()
        let ref = Database.database().reference(withPath: "Records").child("Level"+String(self.level))
        let tmp = ref.queryOrdered(byChild: "scores").queryLimited(toLast: 5)
        print(tmp)
        ref.queryOrdered(byChild: "scores").queryLimited(toLast: 5).observeSingleEvent(of: .childAdded, with: { snapshot in
            let dictionary = snapshot.value as? [String: AnyObject]
            let user = (dictionary?["user"] as? String)!
            let score = (dictionary?["scores"] as? Int)!
            let r = rank(user: user, score: score)
            
            ranks.append(r)
        })
        
        return ranks
    }
    
}
