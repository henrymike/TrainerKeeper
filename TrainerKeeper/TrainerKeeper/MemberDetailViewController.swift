//
//  MemberDetailViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 11/30/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class MemberDetailViewController: UIViewController {
    
    //MARK: - Properties
    var selectedMember :PFObject?
    var selectedClass  :PFObject?
    
    @IBOutlet weak var firstNameTextField   :UITextField!
    @IBOutlet weak var lastNameTextField    :UITextField!
    @IBOutlet weak var classNameTextField   :UITextField!

    
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
        if selectedMember!["parent"] != nil{
            classNameTextField.text = (selectedMember!["parent"]["groupName"] as! String)
        } else {
            print("Class Name Error")
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        selectedMember!.deleteInBackground()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Pressed")
        
        //TODO: SHOULDN'T CREATE CLASS HERE SHOULD USE SELECTED FROM LIST
        let selectedClass = PFObject(className: "Classes")
        selectedClass["groupName"] = classNameTextField.text

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
    
    
    //MARK: - Life Cycle Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedMember != nil {
            displaySelectedMemberProfile()
        }
        
        
    }
    
}
