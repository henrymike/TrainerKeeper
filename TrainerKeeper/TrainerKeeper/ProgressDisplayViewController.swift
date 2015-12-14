//
//  ProgressDisplayViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

//
//  ProgressDisplayViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ProgressDisplayViewController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMemberArray :[PFObject?] = []
    var selectedDataArray :[PFObject?] = []
    @IBOutlet weak var progressGraphView :BEMSimpleLineGraphView!
    
    
    
    //MARK: - Graph View Methods
    
//    func filterDataByMember(group: PFObject) -> [PFObject] {
//        let filteredData = selectedDataArray.filter({$0["member"] as! PFObject == group})
//        return filteredData
//    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        //        let filteredArray = filterDataByMember(dataManager.exercisesDataArray)
        //        return filteredArray.count
        return dataManager.workoutDataArray.count
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        let currentData = dataManager.workoutDataArray[index]
        let reps = currentData["exerciseReps"] as! CGFloat
        return reps
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        let currentData = dataManager.workoutDataArray[index]
        let dateUpdated = currentData.updatedAt! as NSDate
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "M/d/yy"
        let date = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated))
        return date as String
    }
    
    func graphCustomizations() {
        self.progressGraphView.enablePopUpReport = true
        self.progressGraphView.widthLine = 4.0
        self.progressGraphView.sizePoint = 20.0
        self.progressGraphView.colorTop = UIColor.init(red: 255/255, green: 104/255, blue: 29/255, alpha: 1)
        self.progressGraphView.alphaTop = 0.8
        self.progressGraphView.colorBottom = UIColor.init(red: 255/255, green: 104/255, blue: 29/255, alpha: 1)
        self.progressGraphView.averageLine.enableAverageLine = true
        self.progressGraphView.averageLine.dashPattern = [2,3,3,2]
        self.progressGraphView.enableReferenceAxisFrame = true
        self.progressGraphView.enableReferenceXAxisLines = true
        self.progressGraphView.enableReferenceYAxisLines = false
//        self.progressGraphView.enableRightReferenceAxisFrameLine = true
//        self.progressGraphView.enableTopReferenceAxisFrameLine = true
        self.progressGraphView.alwaysDisplayDots = true
        self.progressGraphView.alwaysDisplayPopUpLabels = true
        
    }
    
    
    //MARK: Life Cycle Methods
    
    func receivedWorkoutDataFromServer() {
        print("Got Workout Data")
        let navTitle = selectedDataArray["exercise"]
        self.title = ""
        graphCustomizations()
        progressGraphView.reloadGraph()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected Member Array: \(selectedMemberArray)")
        print("Selected Data Array: \(selectedDataArray)")
        dataManager.fetchWorkoutDetailFromParse(selectedMemberArray[0]!, exercise: selectedDataArray[0]!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedWorkoutDataFromServer", name: "receivedWorkoutDataFromServer", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

