//
//  RecordDataViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse
import CoreFoundation

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
        var memberCell : RecordTableViewCell
        let currentExerciseType = recordDataArray[indexPath.section]!["type"] as! String
        if currentExerciseType != "Time" {
//            memberCell = RecordTableViewCell()
//            memberCell = self.recordMemberArray
            memberCell = tableView.dequeueReusableCellWithIdentifier("recordExerciseRepsCell", forIndexPath: indexPath) as! RecordTableViewCell
//            memberCell.prepareForReuse()
        } else {
            memberCell = tableView.dequeueReusableCellWithIdentifier("recordExerciseTimeCell", forIndexPath: indexPath) as! RecordTableViewCell
//            memberCell.prepareForReuse()
        }
        let recordMember = recordMemberArray[indexPath.row]
        memberCell.memberLabel.text = "\(recordMember!["firstName"] as! String!) \(recordMember!["lastName"] as! String!)"
        return memberCell
    }
    
    
    
    
    //MARK: - Stopwatch Methods
    
    var startTime = NSTimeInterval()
    var recStartTime: CFAbsoluteTime!
    var timer = NSTimer()
    var stopwatchTimeDisplay = String()
    var stopwatchTimeSeconds = 0.0
    @IBOutlet weak var stopwatchLabel :UILabel!
    
    func stopwatchUpdateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        let elapsedTime: NSTimeInterval = currentTime - startTime
        var timeToDisplay = elapsedTime
        let minutes = UInt8(timeToDisplay / 60.0)
        timeToDisplay -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(timeToDisplay)
        timeToDisplay -= NSTimeInterval(seconds)
        let fraction = UInt8(timeToDisplay * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        stopwatchTimeDisplay = ("\(strMinutes):\(strSeconds):\(strFraction)")
        stopwatchLabel.text = stopwatchTimeDisplay
        stopwatchTimeSeconds = elapsedTime
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        if !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "stopwatchUpdateTime", userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    @IBAction func stopButtonPressed() {
        timer.invalidate()
    }
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        let point = sender.convertPoint(CGPointZero, toView: recordTableView)
        let indexPath = recordTableView.indexPathForRowAtPoint(point)!
        let cell = recordTableView.cellForRowAtIndexPath(indexPath) as! RecordTableViewCell
        let member = recordMemberArray[indexPath.row]
        let currentMemberFirstName = (member!["firstName"] as! String)
        let currentMemberLastName = (member!["lastName"] as! String)
        let currentExerciseName = recordDataArray[indexPath.section]!["name"] as! String
        let currentWorkout = filterWorkoutDetail(currentMemberFirstName, memberLastName: currentMemberLastName, exerciseName: currentExerciseName)
        currentWorkout.exerciseSeconds = Double(stopwatchTimeSeconds) // record time in seconds
        cell.memberRecordLabel.text = stopwatchTimeDisplay // display human-readable time
        
        print("memberFN:\(currentWorkout.memberFirstName) memberLN:\(currentWorkout.memberLastName) exercise:\(currentWorkout.exerciseName) reps:\(currentWorkout.exerciseReps) time:\(currentWorkout.exerciseSeconds) measure:\(currentWorkout.exerciseMeasure)")
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
        
        let currentExerciseType = recordDataArray[indexPath.section]!["type"] as! String
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
        
        print("memberFN:\(currentWorkout.memberFirstName) memberLN:\(currentWorkout.memberLastName) exercise:\(currentWorkout.exerciseName) reps:\(currentWorkout.exerciseReps) time:\(currentWorkout.exerciseSeconds) measure:\(currentWorkout.exerciseMeasure)")
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save button pressed")
        for detail in workoutDetailArray {
            let recordMember = PFObject(className: "WorkoutDetail")
            recordMember["member"] = detail.member
            recordMember["exercise"] = detail.exercise
            if detail.exerciseReps != nil {
                recordMember["exerciseReps"] = detail.exerciseReps
            }
            if detail.exerciseMeasure != nil {
                recordMember["exerciseMeasure"] = detail.exerciseMeasure
            }
            if detail.exerciseSeconds != nil {
                recordMember["exerciseSeconds"] = detail.exerciseSeconds
            }
            print("Record Member: \(recordMember)")
            self.stopButtonPressed()
            recordMember.saveInBackground()
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWorkoutDetailArray()
//        print("Segue Array: \(recordDataArray)")
//        print("Segue Member: \(recordMemberArray)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
