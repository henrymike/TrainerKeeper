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
    
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.fetchMembersFromParse()
        dataManager.fetchClassesFromParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

