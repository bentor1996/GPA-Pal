//
//  SemesterConfig.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/17/17.
//  Copyright © 2017 Omar Olivarez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func getAllCourses() -> [NSManagedObject] {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Course")
    
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

func getCourseWithID(courseID: NSManagedObjectID) -> NSManagedObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    return managedContext.object(with: courseID)
    
}

func addSectionToCourse(courseID: NSManagedObjectID, sectionList: NSManagedObject) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let course = managedContext.object(with: courseID)
    
    //semester.setValue(courseList, forKey: "courses")
    course.mutableSetValue(forKey: "sectionList").add(sectionList)
    
    do {
        try managedContext.save()
    } catch {
        // what to do if an error occurs?
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
}

func getSectionList(course: NSManagedObject) -> [NSManagedObject] {
    let SectionSet = course.mutableSetValue(forKey: "sectionList")
    var SectionList = [NSManagedObject]()
    
    for section in SectionSet {
        SectionList.append(section as! NSManagedObject)
    }
    
    if SectionSet.count == 0 {
        return [NSManagedObject]()
    } else {
        return SectionList
    }
}
/*
func getCourseGoal(course: NSManagedObject) -> String {
    let courseGoal = course.value(forKey: "gradeGoal") as? String
    print(courseGoal)
    if courseGoal != nil {
        return courseGoal!
    } else {
        let cg = "-"
        return cg
    }
}*/



func setCourseAverage(course: NSManagedObject, average: Float) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    course.setValue(average, forKey: "grade")
    do {
        try managedContext.save()
    } catch {
        // what to do if an error occurs?
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
    }
}







