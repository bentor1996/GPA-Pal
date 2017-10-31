//
//  Config.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 10/31/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import Foundation

class Config: NSObject {
    // Define keys for the values to store
    fileprivate static let kUserIdKey = "userId"
    fileprivate static let kPasswordKey = "password"
    
    class func setUserId(_ userId:Int) {
        UserDefaults.standard.set(userId, forKey: kUserIdKey)
        UserDefaults.standard.synchronize()
    }
    class func setPassword(_ name:String) {
        UserDefaults.standard.set(name, forKey: kPasswordKey)
        UserDefaults.standard.synchronize()
    }
    
    class func userId() -> Int {
        return UserDefaults.standard.integer(forKey: kUserIdKey)
    }
    class func password() -> String {
        return UserDefaults.standard.object(forKey: kPasswordKey) as! String
    }
}
