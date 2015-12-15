//
//  RecordSelectViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class RecordSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var recordMemberArray :[PFObject?] = []
    var recordDataArray :[PFObject?] = []
//    @IBOutlet weak var recordSelectTableView  :UITableView!
    @IBOutlet weak var recordSelectCollectionView :UICollectionView!
    
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.exercisesDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        recordSelectCollectionView.allowsMultipleSelection = true
        let exerciseCell = collectionView.dequeueReusableCellWithReuseIdentifier("exerciseCell", forIndexPath: indexPath) as! ExercisesCollectionViewCell
        let currentExercise = dataManager.exercisesDataArray[indexPath.row]
        exerciseCell.exerciseLabel.text = "\(currentExercise["name"] as! String!)"
        exerciseCell.exerciseImageView.image = UIImage(named: "item-unselected")
        
        return exerciseCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = recordSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == true {
            selectedCell.exerciseImageView.image = UIImage(named: "item-selected")
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = recordSelectCollectionView.cellForItemAtIndexPath(indexPath) as! ExercisesCollectionViewCell
        if selectedCell.selected == false {
            selectedCell.exerciseImageView.image = UIImage(named: "item-unselected")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(125, 140)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberRecord" {
            if let indexPaths = recordSelectCollectionView.indexPathsForSelectedItems() {
                for indexPath in indexPaths {
                    recordDataArray.append(dataManager.exercisesDataArray[indexPath.row])
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
