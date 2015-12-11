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
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        dataManager.fetchMembersFromParse()
        dataManager.fetchClassesFromParse()
        dataManager.fetchWorkoutDetailFromParse()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

