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
    
    func filterMemberByClass(groupName: String) -> [PFObject] {
        //        let groupName = (dataManager.membersDataArray["parent"]["groupName"] as! PFObject)
        let filteredMembers = dataManager.membersDataArray.filter({$0.objectForKey("groupName") as! String == groupName
        })
        print("Filtered Members: \(filteredMembers)")
        return filteredMembers
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataManager.classesDataArray.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.membersDataArray.count
//        return filterMemberByClass(dataManager.membersDataArray[section]).count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (dataManager.classesDataArray[section]["groupName"] as! String)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memberCell = tableView.dequeueReusableCellWithIdentifier("selectCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentMember = dataManager.membersDataArray[indexPath.row]
        
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
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let memberToDelete = dataManager.membersDataArray[indexPath.row]
            memberToDelete.deleteInBackground()
            dataManager.fetchMembersFromParse()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberSelect" {
            let destController = segue.destinationViewController as! RecordSelectViewController
            
            if let indexPaths = membersTableView.indexPathsForSelectedRows {
                for indexPath in indexPaths {
                    let selectedMember = dataManager.membersDataArray[indexPath.row]
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
    