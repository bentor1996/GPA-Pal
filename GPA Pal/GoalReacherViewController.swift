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
        // calculate average for % system
        // first, the section average must be recalculated
        var requiredGrade = -1
        var calculatedCourseGrade = 0.0
        let cGrade = course?.value(forKey: "grade") as! Double
        let gGoal = course?.value(forKey: "gradeGoal") as! Double
        let cPTotal = course?.value(forKey: "pointstotal") as? Double
        if cGrade < gGoal {
            let assignmentList = getAssignmentList(section: selectedSection!)
            if assignmentList.count < 1 {
                //let valueToReturn = selectedSection!.value(forKey: "weight") as! Double
                //let vTR = String(valueToReturn)
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
                return "100" // I think this is right? At least for % it should be
                // and actually, if we're just saying that you're 'average' or grade after being converted to a 0-100 point scale is what we're
                // returning, then this should also be fine
            } else {
                // calculate the lowest grade they can get to still earn their grade goal
                requiredGrade = Int(cGrade)
                var calculatedCourseGrade = 0.0
                while (calculatedCourseGrade > gGoal) {
                    var total = 0
                    requiredGrade -= 1
                    let assignmentList = getAssignmentList(section: selectedSection!)
                    if assignmentList.count < 1 {
                        //let valueToReturn = selectedSection!.value(forKey: "weight") as! Double
                        //let vTR = String(valueToReturn)
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
        if requiredGrade > 100 {
            self.warning.text = "This grade is above 100% - it may be difficult to reach this goal"
        } else {
            self.warning.text = " "
        }
        return (String(requiredGrade))
    }
    
    func reCalculate (average: Double) -> Double {
        var currentGrade = 0.0
        let cPTotal = course?.value(forKey: "pointstotal") as? Double
        if course?.value(forKey: "totalType") as? String == "Percent" {
            for sec in sections! {
                let sectionName = sec.value(forKey: "name") as? String
                let thisSectionName = selectedSection?.value(forKey: "name") as? String
                if sectionName == thisSectionName {
                    // use average rather than the stored average
                    currentGrade += (sec.value(forKey: "weight") as! Double) * (average/100)
                    print("passed in average")
                    print(average)
                } else {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
                }
            }
        } else {
            for sec in sections! {
                let sectionName = sec.value(forKey: "name") as? String
                let thisSectionName = selectedSection?.value(forKey: "name") as? String
                if sectionName == thisSectionName {
                    // use average rather than the stored average
                    currentGrade += (sec.value(forKey: "weight") as! Double) * average
                } else {
                    currentGrade += (sec.value(forKey: "weight") as! Double) * ((sec.value(forKey: "average") as! Double)/cPTotal!)
                }
            }
        }
        print(currentGrade)
        return Double(currentGrade)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
