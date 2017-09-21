//
//  User.swift
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
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
            "password": password,
            "points": points,
            "coints": coints
        ]
    }
}
