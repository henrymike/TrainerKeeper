//
//  ClassesViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/2/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ClassesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet weak var classesTableView :UITableView!
    
    
    
    
    //MARK: Table View Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.classesDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCellWithIdentifier("classCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentClass = dataManager.classesDataArray[indexPath.row]
        classCell.textLabel!.text = "\(currentClass["groupName"] as! String!)"
        classCell.detailTextLabel!.text = "\(currentClass["times"] as! String!)"
        
        return classCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let memberToDelete = dataManager.classesDataArray[indexPath.row]
            memberToDelete.deleteInBackground()
            dataManager.fetchClassesFromParse()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueClassEdit" {
            let destController = segue.destinationViewController as! ClassesDetailViewController
            let indexPath = classesTableView.indexPathForSelectedRow!
            let selectedClass = dataManager.classesDataArray[indexPath.row]
            destController.selectedClass = selectedClass
            classesTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    func newClassesDataReceived() {
        classesTableView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        
        dataManager.fetchClassesFromParse()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newClassesDataReceived", name: "receivedClassesDataFromServer", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dataManager.fetchClassesFromParse()
    }
    
}
