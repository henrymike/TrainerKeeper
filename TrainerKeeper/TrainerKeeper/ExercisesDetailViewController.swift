//
//  ExercisesDetailViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ExercisesDetailViewController: UIViewController {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedExercise  :PFObject?
    
    @IBOutlet weak var exerciseNameTextField   :UITextField!
    
    
    //MARK: - Display Methods
    
    func displaySelectedExerciseDetails() {
        if selectedExercise!["name"] != nil {
            exerciseNameTextField.text = (selectedExercise!["name"] as! String)
        } else {
            print("Exercise Name Error")
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        selectedExercise!.deleteInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Pressed")
        
        if selectedExercise == nil {
            selectedExercise = PFObject(className: "Exercises")
        }
        selectedExercise!["name"] = exerciseNameTextField.text
        
        saveAndPop()
    }
    
    func saveAndPop() {
        selectedExercise!.saveInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedExercise != nil {
            displaySelectedExerciseDetails()
        }
    }
    
    
}
