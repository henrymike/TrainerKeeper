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
    
    
    
    //MARK: Life Cycle Methods
    
    func receivedWorkoutDataFromServer() {
        print("Got Workout Data")
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

