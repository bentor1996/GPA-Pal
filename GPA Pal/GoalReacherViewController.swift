//
//  GoalReacherViewController.swift
//  GPA Pal
//
//  Created by Omar Olivarez on 11/14/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData

class GoalReacherViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var selectedSection: NSManagedObject?
    var course: NSManagedObject?
    var courseID: NSManagedObjectID?
    var sections: [NSManagedObject]?
    @IBOutlet weak var goalLabel: UIView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var requiredGrade: UILabel!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var settingsBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        course = getCourseWithID(courseID: courseID!)
        sections = getSectionList(course: course!)
        settingsBtn.image = UIImage(named: "settings")
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
        selectedSection = sections![0]
        self.requiredGrade.text = calculateCourseAverage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections![row].value(forKey: "name") as? String
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = sections![row]
        self.requiredGrade.text = calculateCourseAverage()
    }
    
    func calculateCourseAverage() -> String {
        var requiredGrade = -1
        var calculatedCourseGrade = 0.0
        if course?.value(forKey: "totalType") as? String == "Percent" {
            let cGrade = course?.value(forKey: "grade") as! Double
            let gGoal = course?.value(forKey: "gradeGoal") as! Double
            let cPTotal = course?.value(forKey: "pointstotal") as? Double
            if cGrade < gGoal {
                let assignmentList = getAssignmentList(section: selectedSection!)
                if assignmentList.count < 1 {
                    let vTR = "100"
                    requiredGrade = 100
                    self.warning.text = " "
                    return vTR
                }
                
                while calculatedCourseGrade < gGoal {
                    print(1)
                    var total = 0
                    var average = 0
                    requiredGrade += 1
                    for ass in assignmentList {
                        total += ass.value(forKey: "grade") as! Int
                    }
                    total += requiredGrade
                    average = total/(assignmentList.count + 1)
                    calculatedCourseGrade = reCalculate(average: Double(average))
                }
                
            } else if cGrade >= gGoal {
                if cGrade == gGoal {
                    requiredGrade = 100
                    self.warning.text = " "
                    return "100"
                } else {
                    requiredGrade = Int(cGrade)
                    var calculatedCourseGrade = 0.0
                    while (calculatedCourseGrade > gGoal) {
                        var total = 0
                        requiredGrade -= 1
                        let assignmentList = getAssignmentList(section: selectedSection!)
                        if assignmentList.count < 1 {
                            let vTR = "100"
                            requiredGrade = 100
                            self.warning.text = " "
                            return vTR
                        } else {
                            for ass in assignmentList {
                                total += ass.value(forKey: "grade") as! Int
                            }
                            total += requiredGrade
                            let average = total/(assignmentList.count + 1)
                            calculatedCourseGrade = reCalculate(average: Double(average))
                        }
                    }
                }
            }
        // else, if this is the POINTS SYSTEM
        } else {
            let cGrade = course?.value(forKey: "grade") as! Double
            let gGoal = (course?.value(forKey: "gradeGoal") as! Double)
            let cPTotal = course?.value(forKey: "pointstotal") as? Double
            var total = 0
            let assignmentList = getAssignmentList(section: selectedSection!)
            var ccGrade = 0.0
            for sec in sections! {
                ccGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
            }
            for ass in assignmentList {
                total += ass.value(forKey: "grade") as! Int
            }
            let weight = selectedSection?.value(forKey: "weight") as! Float
            let average = ((Float(total)/weight) * 100) / 2
            ccGrade = ccGrade * 2 * 10 // THIS IS THE CURRENT GRADE
            print("OGOGOGO")
            print(weight)
            print(total)
            print(gGoal)
            setSectionAverage(section: selectedSection!, average: Float(average))
            var difference = weight - Float(total) // TOTAL POINTS FOR THIS SECTION MINUS POINTS EARNED FOR THIS SECTION
            print(difference)
            print(ccGrade)
            if (Float(ccGrade) + difference ) < Float(gGoal) {
                print(ccGrade)
                print(difference)
                print(gGoal)
                print("HEREEEE")
                requiredGrade = Int(difference) // this means it's impossible to reach your goal
                self.warning.text = "You need more points than are left in this section, you will need more points in your other sections to accomplish your goal."
            } else if (Float(ccGrade) + difference ) > Float(gGoal){
                while (Float(ccGrade) + difference ) > Float(gGoal) {
                    difference -= 1
                    print(difference)
                    print("~o")
                }
                if difference <= 0{
                    difference = 0 // this means you have excess capacity to reach your goal
                }
                requiredGrade = Int(difference)
            } else {
                requiredGrade = 0
                requiredGrade = Int(difference) // this means you have exactly met your goal
                self.warning.text = "You need more points than are left in this section, you will need more points in your other sections to accomplish your goal."
            }
        }
        
        if requiredGrade > 100 {
            if course?.value(forKey: "totalType") as? String == "Percent" {
                self.warning.text = "This grade is above 100% - it may be difficult to reach this goal"
            }
            else {
                self.warning.text = " "
            }
        }
        let weight = selectedSection?.value(forKey: "weight") as! Float
        if course?.value(forKey: "totalType") as? String != "Percent" {
            if (Float(requiredGrade) > weight) {
                print(requiredGrade)
                print(weight)
                print("WHATTT")
                requiredGrade = -1
                self.warning.text = "You need more points than are left in this section, you will need more points in your other sections to accomplish your goal."
            }
        }
        print(requiredGrade)
        let gGoal = (course?.value(forKey: "gradeGoal") as! Double)
        var ccGrade = 0.0
        ccGrade = ccGrade * 2 * 10
        let cPTotal = course?.value(forKey: "pointstotal") as? Double
        for sec in sections! {
            ccGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
        }
        
        if requiredGrade < 0{
            self.warning.text = "You need more points than are left in this section, you will need more points in your other sections to accomplish your goal."
            return ("0")
        } else if (requiredGrade == 0) && (ccGrade == gGoal) {
            self.warning.text = "You have reached this class's Grade Goal."
            return ("0")
        }else if requiredGrade == 0 {
            self.warning.text = "You need more points than are left in this section, you will need more points in your other sections to accomplish your goal."
            return ("0")
        }else {
            self.warning.text = " "
            return (String(requiredGrade))
        }
    }
    
    func reCalculate (average: Double) -> Double {
        var currentGrade = 0.0
        let cPTotal = course?.value(forKey: "pointstotal") as? Double
        print(cPTotal!)
        if course?.value(forKey: "totalType") as? String == "Percent" {
            for sec in sections! {
                let sectionName = sec.value(forKey: "name") as? String
                let thisSectionName = selectedSection?.value(forKey: "name") as? String
                if sectionName == thisSectionName {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * (average/100)
                } else {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
                }
            }
        } else {
            for sec in sections! {
                let sectionName = sec.value(forKey: "name") as? String
                let thisSectionName = selectedSection?.value(forKey: "name") as? String
                if sectionName == thisSectionName {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * average
                } else {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
                }
            }
        }
        print(currentGrade)
        return Double(currentGrade)
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSettings4", sender: nil)
    }
}
