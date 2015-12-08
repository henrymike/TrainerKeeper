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
    var member :PFObject?
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
                newWorkout.memberName = (member!["firstName"] as! String) + (member!["lastName"] as! String)
                newWorkout.exercise = exercise
                newWorkout.exerciseName = exercise!["name"] as! String
                workoutDetailArray.append(newWorkout)
            }
        }
    }
    
    func filterWorkoutDetail(memberName: String, exerciseName: String) -> WorkoutDetail {
        // ASSUMES NO DUPLICATE USERS OR EXERCISES
        let tempArray = workoutDetailArray.filter({$0.memberName == memberName && $0.exerciseName == exerciseName})
        return tempArray[0]
    }
    
    @IBAction func dataValueChanged(sender: UITextField) {
        let point = sender.convertPoint(CGPointZero, toView: recordTableView)
        let indexPath = recordTableView.indexPathForRowAtPoint(point)!
        let cell = recordTableView.cellForRowAtIndexPath(indexPath) as! RecordTableViewCell
        let member = recordMemberArray[indexPath.row]
        let currentMemberName = (member!["firstName"] as! String) + (member!["lastName"] as! String)
        let currentExerciseName = recordDataArray[indexPath.section]!["name"] as! String
        let currentWorkout = filterWorkoutDetail(currentMemberName, exerciseName: currentExerciseName)
        currentWorkout.exerciseReps = Int(cell.memberRecordTextField.text!)
        print("member:\(currentWorkout.memberName) exercise:\(currentWorkout.exerciseName) reps:\(currentWorkout.exerciseReps)")
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save button pressed")
//        let value : RecordTableViewCell!
//        let value2 = value.memberRecordTextField.text
//        for value2 in recordTableView {
//            print("Something")
//        }
//        for value.memberRecordTextField.text
//        for memberRecordTextField.text in RecordTableViewCell {
//        }
//        let editedField = value2
//        let indexPaths = recordTableView.indexPathForCell(editedField)
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
