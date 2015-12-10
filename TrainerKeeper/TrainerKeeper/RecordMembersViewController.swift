//
//  RecordMembersViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class RecordMembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var recordMemberArray :[PFObject?] = []
    @IBOutlet weak var membersTableView :UITableView!
    
    
    
    //MARK: - Table View Methods
    
    func filterMemberByClass(group: PFObject) -> [PFObject] {
        let filteredMembers = dataManager.membersDataArray.filter({$0["parent"] as! PFObject == group})
        return filteredMembers
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataManager.classesDataArray.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredArray = filterMemberByClass(dataManager.classesDataArray[section])
        return filteredArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (dataManager.classesDataArray[section]["groupName"] as! String)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memberCell = tableView.dequeueReusableCellWithIdentifier("selectCell", forIndexPath:
            indexPath) as UITableViewCell
        let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
        let currentMember = filteredArray[indexPath.row]
        
        memberCell.textLabel!.text = "\(currentMember["firstName"] as! String!) \(currentMember["lastName"] as! String!)"
        
        return memberCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = membersTableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = membersTableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberSelect" {
            let destController = segue.destinationViewController as! RecordSelectViewController
            
            if let indexPaths = membersTableView.indexPathsForSelectedRows {
                for indexPath in indexPaths {
                    let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
                    let selectedMember = filteredArray[indexPath.row]
                    recordMemberArray.append(selectedMember)
                }
                destController.recordMemberArray = recordMemberArray
            }
        }
    }
    

    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchExercisesFromParse()
    }
    
    override func viewDidAppear(animated: Bool) {
        recordMemberArray.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    