//
//  Resource.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 12/2/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import Foundation

class Resource {
    private var _name: String = "<not set>"
    private var _number: String = "<not set>"
    
    var name: String {
        get { return _name }
        set(value) { _name = value }
    }
    var number: String {
        get { return _number }
        set(value) { _number = value }
    }
    
    init() {
    }
    
    init(name: String, number: String) {
        self.name = name
        self.number = number
    }
}
