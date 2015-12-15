//
//  ProgressSelectViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ProgressSelectViewController: UIViewController {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMemberArray :[PFObject?] = []
    var selectedDataArray :[PFObject?] = []
    var graphTitle :String = ""
    @IBOutlet weak var dataSelectCollectionView :UICollectionView!
    
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.exercisesDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        dataSelectCollectionView.allowsMultipleSelection = true
        let exerciseCell = collectionView.dequeueReusableCellWithReuseIdentifier("dataCell", forIndexPath: indexPath) as! ExercisesCollectionViewCell
        let currentExercise = dataManager.exercisesDataArray[indexPath.row]
        exerciseCell.exerciseLabel.text = "\(currentExercise["name"] as! String!)"
        exerciseCell.exerciseImageView.image = UIImage(named: "progress-unselected")
        
        return exerciseCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = dataSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == true {
            selectedCell.exerciseImageView.image = UIImage(named: "progress-selected")
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = dataSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == false {
            selectedCell.exerciseImageView.image = UIImage(named: "progress-unselected")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(125, 140)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueDataSelect" {
            if let indexPaths = dataSelectCollectionView.indexPathsForSelectedItems() {
                for indexPath in indexPaths {
                    selectedDataArray.append(dataManager.exercisesDataArray[indexPath.row])
                    dataSelectCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
                }
            }
            let selectedExerciseType = selectedDataArray[0]!["name"] as! String
            graphTitle = selectedExerciseType
            let destController = segue.destinationViewController as! ProgressDisplayViewController
            destController.selectedDataArray = selectedDataArray
            destController.selectedMemberArray = selectedMemberArray
            destController.graphTitle = graphTitle
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedDataArray.removeAll()
        dataManager.workoutDataArray.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

