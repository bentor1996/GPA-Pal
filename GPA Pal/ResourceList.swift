//
//  ResourceList.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 12/2/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import Foundation

class ResourceList {
    private var resources = [Resource]()
    
    func count() -> Int {
        return resources.count
    }
    
    func addResource(name: String, number: String) {
        resources.append(Resource(name: name, number: number))
    }
    
    func getResource(index: Int) -> Resource {
        guard index < resources.count else { return Resource() }
        return resources[index]
    }
    
}
