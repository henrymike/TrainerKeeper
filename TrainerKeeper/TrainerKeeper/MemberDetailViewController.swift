//
//  MemberDetailViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 11/30/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class MemberDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMember :PFObject?
    var selectedClass  :PFObject?
    
    @IBOutlet weak var firstNameTextField   :UITextField!
    @IBOutlet weak var lastNameTextField    :UITextField!
    @IBOutlet weak var classPicker          :UIPickerView!
    @IBOutlet weak var saveBarButtonItem    :UIBarButtonItem!

    
    //MARK: - Display Methods
    
    func displaySelectedMemberProfile() {
        if selectedMember!["firstName"] != nil {
            firstNameTextField.text = (selectedMember!["firstName"] as! String)
        } else {
            print("First Name Error")
        }
        if selectedMember!["lastName"] != nil {
            lastNameTextField.text = (selectedMember!["lastName"] as! String)
        } else {
            print("Last Name Error")
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        selectedMember!.deleteInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Pressed")
        
        if selectedMember == nil {
            selectedMember = PFObject(className: "Members")
        }
        selectedMember!["firstName"] = firstNameTextField.text
        selectedMember!["lastName"] = lastNameTextField.text
        selectedMember!["parent"] = selectedClass
        
        saveAndPop()
    }
    
    func saveAndPop() {
        selectedMember!.saveInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - Picker View Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataManager.classesDataArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (dataManager.classesDataArray[row].objectForKey("groupName") as! String)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selection = classPicker.selectedRowInComponent(0)
        selectedClass = dataManager.classesDataArray[selection]
        saveBarButtonItem.enabled = true
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedMember != nil {
            displaySelectedMemberProfile()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // set initial picker value if Class has been assigned to Member
        guard let uSelectedMember = selectedMember else {
            return
        }
        guard let uSelectedParent = uSelectedMember["parent"] else {
            return
        }
        if uSelectedParent["groupName"] != nil {
            let parent = selectedMember!["parent"] as! PFObject
            let index = dataManager.classesDataArray.indexOf(parent)!
            classPicker.selectRow(index, inComponent: 0, animated: false)
            saveBarButtonItem.enabled = true
        }
        
    }
    
}
