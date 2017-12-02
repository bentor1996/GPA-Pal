//
//  GraphViewController.swift
//  GPA Pal
//
//  Created by Ben Torres on 12/2/17.
//  Copyright © 2017 Ben Torres. All rights reserved.
//

import UIKit
import CoreData
import Charts

class GraphViewController: UIViewController {
    
    var semesterID: NSManagedObjectID?
    var semester: NSManagedObject?
    var courses: [NSManagedObject]?
    var courseList: [String] = []
    var gradeList: [Double] = []
    var average: Double = 0.0

    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        semester = getSemesterWithID(semesterID: semesterID!)
        self.title = (semester?.value(forKey: "name") as? String)! + " Graph"
        self.courses = getCourseList(semester: semester!)
        getLists()
        setChart(dataPoints: courseList, values: gradeList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLists () {
        var total: Double = 0
        for course in courses! {
            let className = course.value(forKey: "name") as? String
            courseList.append(className!)
            let classGrade = course.value(forKey: "grade") as? Double
            gradeList.append(classGrade!)
            let gradeGoal = course.value(forKey: "gradeGoal") as? Double
            total += gradeGoal!
        }
        average = total/Double((courses?.count)!)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need data"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "All Classes")
        let ChartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = ChartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        //barChartView.xAxis.labelPosition
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        let ll = ChartLimitLine(limit: average, label: "Average Goal")
        barChartView.rightAxis.addLimitLine(ll)
        
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
