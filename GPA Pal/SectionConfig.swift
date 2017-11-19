//
//  SectionConfig.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/19/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func getAllSections() -> [NSManagedObject] {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Section")
    
    var fetchedResults:[NSManagedObject]? = nil
    
    do {
        try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
    } catch {
        // what to do if an error occurs?
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
    
    if let results = fetchedResults {
        return results
    } else {
        print("Could not fetch")
        return [NSManagedObject]()
    }
}

func getSectionWithID(sectionID: NSManagedObjectID) -> NSManagedObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    return managedContext.object(with: sectionID)
    
}

func addAssignmentToSection(sectionID: NSManagedObjectID, assignmentList: NSManagedObject) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let section = managedContext.object(with: sectionID)
    
    //semester.setValue(courseList, forKey: "courses")
    section.mutableSetValue(forKey: "assignentList").add(assignmentList)
    
    do {
        try managedContext.save()
    } catch {
        // what to do if an error occurs?
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
}

func getAssignmentList(section: NSManagedObject) -> [NSManagedObject] {
    let AssignmentSet = section.mutableSetValue(forKey: "assignmentList")
    var AssignmentList = [NSManagedObject]()
    
    for assignment in AssignmentSet {
        AssignmentList.append(assignment as! NSManagedObject)
    }
    
    if AssignmentSet.count == 0 {
        return [NSManagedObject]()
    } else {
        return AssignmentList
    }
    
}
