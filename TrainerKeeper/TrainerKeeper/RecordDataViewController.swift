//
//  RecordDataViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class RecordDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var recordMemberArray :[PFObject?] = []
    var recordDataArray :[PFObject?] = []
    var workoutDetailArray = [WorkoutDetail]()
    var recordMember :PFObject?
    @IBOutlet weak var recordTableView :UITableView!

    
    
    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return recordDataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordMemberArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (recordDataArray[section]!["name"] as! String)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memberCell = tableView.dequeueReusableCellWithIdentifier("recordMemberCell", forIndexPath: indexPath) as! RecordTableViewCell
        let recordMember = recordMemberArray[indexPath.row]
        memberCell.memberLabel.text = "\(recordMember!["firstName"] as! String!) \(recordMember!["lastName"] as! String!)"
        
        return memberCell
    }
    
    //MARK: - Save Methods
    
    func createWorkoutDetailArray() {
        for exercise in recordDataArray {
            for member in recordMemberArray {
                let newWorkout = WorkoutDetail()
                newWorkout.member = member
                newWorkout.memberFirstName = (member!["firstName"] as! String)
                newWorkout.memberLastName = (member!["lastName"] as! String)
                newWorkout.exercise = exercise
                newWorkout.exerciseName = exercise!["name"] as! String
                workoutDetailArray.append(newWorkout)
            }
        }
    }
    
    func filterWorkoutDetail(memberFirstName: String, memberLastName: String, exerciseName: String) -> WorkoutDetail {
        // TODO: FIX; ASSUMES NO DUPLICATE USERS OR EXERCISES
        let tempArray = workoutDetailArray.filter({$0.memberFirstName == memberFirstName && $0.memberLastName == memberLastName && $0.exerciseName == exerciseName})
        return tempArray[0]
    }
    
    @IBAction func dataValueChanged(sender: UITextField) {
        let point = sender.convertPoint(CGPointZero, toView: recordTableView)
        let indexPath = recordTableView.indexPathForRowAtPoint(point)!
        let cell = recordTableView.cellForRowAtIndexPath(indexPath) as! RecordTableViewCell
        let member = recordMemberArray[indexPath.row]
        let currentMemberFirstName = (member!["firstName"] as! String)
        let currentMemberLastName = (member!["lastName"] as! String)
        let currentExerciseName = recordDataArray[indexPath.section]!["name"] as! String
        let currentWorkout = filterWorkoutDetail(currentMemberFirstName, memberLastName: currentMemberLastName, exerciseName: currentExerciseName)
        
        // TODO: Not able to get correct values for Measure and Seconds; returns nil
        let currentExerciseType = recordDataArray[indexPath.section]!["type"] as! String
        print("Current Exercise Type: \(currentExerciseType)")
        switch currentExerciseType {
        case "Reps":
            currentWorkout.exerciseReps = Int(cell.memberRecordTextField.text!)
        case "Measure":
            currentWorkout.exerciseMeasure = Double(cell.memberRecordTextField.text!)
        case "Time":
            currentWorkout.exerciseSeconds = Double(cell.memberRecordTextField.text!)
        default:
            print("Case Switch Error")
        }
        
        print("memberFN:\(currentWorkout.memberFirstName) memberLN:\(currentWorkout.memberLastName) exercise:\(currentWorkout.exerciseName) reps:\(currentWorkout.exerciseReps)")
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save button pressed")
        for detail in workoutDetailArray {
            let recordMember = PFObject(className: "WorkoutDetail")
            recordMember["member"] = detail.member
            recordMember["exercise"] = detail.exercise
            recordMember["exerciseReps"] = detail.exerciseReps
            print("Record Member: \(recordMember)")
            recordMember.saveInBackground()
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWorkoutDetailArray()
        
        print("Segue Array: \(recordDataArray)")
        print("Segue Member: \(recordMemberArray)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
