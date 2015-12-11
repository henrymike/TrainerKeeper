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
    var recordMemberArray :[PFObject?] = []
    var recordDataArray :[PFObject?] = []
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
//        exerciseCell.exerciseImageView.image = UIImage(named: "placeholder")
        
        return exerciseCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = dataSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == true {
            selectedCell.exerciseImageView.image = UIImage(named: "placeholder-checkmark")
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = dataSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == false {
            selectedCell.exerciseImageView.image = UIImage(named: "placeholder")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(125, 100)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueDataSelect" {
            if let indexPaths = dataSelectCollectionView.indexPathsForSelectedItems() {
                for indexPath in indexPaths {
                    recordDataArray.append(dataManager.exercisesDataArray[indexPath.row])
                }
            }
            let destController = segue.destinationViewController as! ProgressDisplayViewController
//            destController.recordDataArray = recordDataArray
//            destController.recordMemberArray = recordMemberArray
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

