//
//  ExercisesDetailViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ExercisesDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedExercise  :PFObject?
    var selectedType :String!
    
    @IBOutlet weak var exerciseNameTextField   :UITextField!
    @IBOutlet weak var exerciseTypePickerView  :UIPickerView!
    @IBOutlet weak var saveBarButtonItem    :UIBarButtonItem!
    
    
    //MARK: - Display Methods
    
    func displaySelectedExerciseDetails() {
        if selectedExercise!["name"] != nil {
            exerciseNameTextField.text = (selectedExercise!["name"] as! String)
        } else {
            print("Exercise Name Error")
        }
    }
    
    
    //MARK: - Picker View Methods
    
    let exerciseTypeArray = ["-- select type --", "Reps", "Measure", "Time"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseTypeArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseTypeArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = exerciseTypePickerView.selectedRowInComponent(0)
        print(selection)
        selectedType = exerciseTypeArray[selection]
        print(selectedType)
        saveBarButtonItem.enabled = true
    }
    
    
    //MARK: - Save and Delete Methods
    
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
        print(selectedType)
        selectedExercise!["type"] = selectedType
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // set initial picker value if Type has been assigned to Exercise
        guard let uSelectedExercise = selectedExercise else {
            return
        }
        if uSelectedExercise["name"] != nil {
            let exerciseType = selectedExercise!["type"] as! String
            let index = exerciseTypeArray.indexOf(exerciseType)!
            exerciseTypePickerView.selectRow(index, inComponent: 0, animated: false)
            saveBarButtonItem.enabled = true
        }
        
    }
    
    
}
