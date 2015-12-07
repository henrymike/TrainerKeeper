//
//  RecordSelectViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class RecordSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var recordMemberArray :[PFObject?] = []
    var recordDataArray :[PFObject?] = []
    @IBOutlet weak var recordSelectTableView  :UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.exercisesDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCellWithIdentifier("recordSelectCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentExercise = dataManager.exercisesDataArray[indexPath.row]
        classCell.textLabel!.text = "\(currentExercise["name"] as! String!)"
        
        return classCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = recordSelectTableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = recordSelectTableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberRecord" {
            if let indexPaths = recordSelectTableView.indexPathsForSelectedRows {
                for indexPath in indexPaths {
                    let selectedExercise = dataManager.exercisesDataArray[indexPath.row]
                    print("Selected Exercises: \(selectedExercise)")
                    recordDataArray.append(selectedExercise)
                    print("Record Data Array: \(recordDataArray)")
                }
            }
            let destController = segue.destinationViewController as! RecordDataViewController
            destController.recordDataArray = recordDataArray
            destController.recordMemberArray = recordMemberArray
        }
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func nextButtonPressed(sender: UIBarButtonItem) {
        //TODO: Disable Next button until selection is made
    }
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        recordDataArray.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  

}
