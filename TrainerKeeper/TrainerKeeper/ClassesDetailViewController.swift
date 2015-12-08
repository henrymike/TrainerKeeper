//
//  ClassesDetailViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ClassesDetailViewController: UIViewController {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedClass    :PFObject?
    var selectedWorkout  :PFObject?
    
    @IBOutlet weak var classNameTextField   :UITextField!
    @IBOutlet weak var classTimeTextField   :UITextField!
    @IBOutlet weak var corporateSwitch      :UISwitch!
    @IBOutlet weak var allowRandomSwitch    :UISwitch!

    
    //MARK: - Display Methods
    
    func displaySelectedClassDetails() {
        if selectedClass!["groupName"] != nil {
            classNameTextField.text = (selectedClass!["groupName"] as! String)
        } else {
            print("Class Name Error")
        }
        if selectedClass!["times"] != nil {
            classTimeTextField.text = (selectedClass!["times"] as! String)
        } else {
            print("Times Error")
        }
        if selectedClass!["corporate"] != nil {
            corporateSwitch.on = (selectedClass!["corporate"] as! Bool)
        } else {
            print("Last Name Error")
        }
        if selectedClass!["randoms"] != nil {
            allowRandomSwitch.on = (selectedClass!["randoms"] as! Bool)
        } else {
            print("Last Name Error")
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        selectedClass!.deleteInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Pressed")
        
        if selectedClass == nil {
            selectedClass = PFObject(className: "Classes")
        }
        selectedClass!["groupName"] = classNameTextField.text
        selectedClass!["times"] = classTimeTextField.text
        selectedClass!["corporate"] = corporateSwitch.on
        selectedClass!["randoms"] = allowRandomSwitch.on
        
        selectedClass!["parent"] = selectedWorkout
        
        saveAndPop()
    }
    
    func saveAndPop() {
        selectedClass!.saveInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedClass != nil {
            displaySelectedClassDetails()
        }
    }
    
    
}
