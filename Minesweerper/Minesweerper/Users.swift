//
//  Users.swift
//  Minesweerper
//
//  Created by Dan Luo on 2017/9/20.
//  Copyright © 2017年 Dan Luo. All rights reserved.
//

import Foundation

public class Users {
    let email: String
    var username: String
    var password: String
    let uid: String
    var points: Int
    var coints: Int
    
    init(email: String, username: String, password: String, uid: String) {
        self.email = email
        self.username = username
        self.password = password
        self.points = 0;
        self.coints = 0;
        self.uid = uid
    }
    
    init(email: String, username: String, password: String, uid: String, points: Int, coints: Int) {
        self.email = email
        self.username = username
        self.password = password
        self.points = points;
        self.coints = coints;
        self.uid = uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.email = dictionary["email"] as! String
        self.username = dictionary["username"] as! String
        self.password = dictionary["password"] as! String
        self.uid = uid
        self.points = dictionary["points"] as! Int
        self.coints = dictionary["coints"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
            "password": password,
            "points": points,
            "coints": coints
        ]
    }
    
    func toTable() -> [AnyHashable: Any] {
        return ["email": email,
                "username": username,
                "password": password,
                "points": points,
                "coints": coints
        ]
    }
}
