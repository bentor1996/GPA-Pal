//
//  SemesterConfig.swift
//  GPA Pal
//
//  Created by Ben Torres on 11/11/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func getAllSemesters() -> [NSManagedObject] {
        
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    let managedContext = appDelegate.persistentContainer.viewContext
        
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Semester")
        
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

func getSemesterWithID(semesterID: NSManagedObjectID) -> NSManagedObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    return managedContext.object(with: semesterID)
    
}

func addCourseToSemester(semesterID: NSManagedObjectID, courseList: NSManagedObject) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let semester = managedContext.object(with: semesterID)
    
    //semester.setValue(courseList, forKey: "courses")
    semester.mutableSetValue(forKey: "courseList").add(courseList)
    
    do {
        try managedContext.save()
    } catch {
        // what to do if an error occurs?
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
}

func getCourseList(semester: NSManagedObject) -> [NSManagedObject] {
    let CourseSet = semester.mutableSetValue(forKey: "courseList")
    var CourseList = [NSManagedObject]()
    
    for course in CourseSet {
        CourseList.append(course as! NSManagedObject)
    }
    
    if CourseSet.count == 0 {
        return [NSManagedObject]()
    } else {
        return CourseList
    }
    
}
    





