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
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var selectedMember = PFObject(className: "Members")
    
    @IBOutlet weak var firstNameTextField   :UITextField!
    @IBOutlet weak var lastNameTextField    :UITextField!

    
    //MARK: - Display Methods
    
    func displaySelectedMemberProfile() {
        if selectedMember["firstName"] != nil {
            firstNameTextField.text = (selectedMember["firstName"] as! String)
        } else {
            print("Error")
        }
        if selectedMember["lastName"] != nil {
            lastNameTextField.text = (selectedMember["lastName"] as! String)
        } else {
            print("Error")
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        do {
            try selectedMember.delete()
        } catch {
            print("Delete Error")
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Pressed")
        selectedMember["firstName"] = firstNameTextField.text
        selectedMember["lastName"] = lastNameTextField.text
        saveAndPop()
    }
    
    func saveAndPop() {
        do {
            try selectedMember.save()
        } catch {
            print("Save Error")
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedMember != "" {
            displaySelectedMemberProfile()
        }
        
        
    }
    
}
