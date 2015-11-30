//
//  ViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 11/30/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    
    
    
    //MARK: - Display Methods
    
    func newMembersDataReceived() {
        
    }
    
    func newClassesDataReceived() {
        
    }
    
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.fetchMembersFromParse()
        dataManager.fetchClassesFromParse()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newMembersDataReceived", name: "receivedMembersDataFromServer", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newClassesDataReceived", name: "receivedClassesDataFromServer", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

