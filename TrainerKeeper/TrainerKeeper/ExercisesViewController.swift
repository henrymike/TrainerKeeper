//
//  ExercisesViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ExercisesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet weak var exercisesTableView :UITableView!
    var detailTitle = ""
    
    
    //MARK: Table View Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.exercisesDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentExercise = dataManager.exercisesDataArray[indexPath.row]
        classCell.textLabel!.text = "\(currentExercise["name"] as! String!)"
        
        return classCell
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            let memberToDelete = dataManager.exercisesDataArray[indexPath.row]
//            memberToDelete.deleteInBackground()
//            dataManager.fetchExercisesFromParse()
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueExerciseEdit" {
            let destController = segue.destinationViewController as! ExercisesDetailViewController
            let indexPath = exercisesTableView.indexPathForSelectedRow!
            let selectedExercise = dataManager.exercisesDataArray[indexPath.row]
            detailTitle = selectedExercise["name"] as! String
            destController.selectedExercise = selectedExercise
            destController.detailTitle = detailTitle
            exercisesTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    func newExercisesDataReceived() {
        exercisesTableView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 82/255, green: 210/255, blue: 56/255, alpha: 1)
        
        dataManager.fetchExercisesFromParse()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newExercisesDataReceived", name: "receivedExercisesDataFromServer", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dataManager.fetchExercisesFromParse()
    }
    
}
