//
//  MembersViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class MembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet weak var membersTableView :UITableView!
    
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.membersDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memberCell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentMember = dataManager.membersDataArray[indexPath.row]
        
        memberCell.textLabel!.text = "\(currentMember["firstName"] as! String!) \(currentMember["lastName"] as! String!)"
        
        //        if currentMember["parent"]["groupName"] != nil{
        //            memberCell.detailTextLabel!.text = currentMember["parent"]["groupName"] as! String!
        //        } else {
        //            print("No Group for Member \(currentMember)")
        //        }
        
        return memberCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let memberToDelete = dataManager.membersDataArray[indexPath.row]
            memberToDelete.deleteInBackground()
            dataManager.fetchMembersFromParse()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberEdit" {
            let destController = segue.destinationViewController as! MembersDetailViewController
            let indexPath = membersTableView.indexPathForSelectedRow!
            let selectedMember = dataManager.membersDataArray[indexPath.row]
            destController.selectedMember = selectedMember
            membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    func newMembersDataReceived() {
        membersTableView.reloadData()
        
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dataManager.fetchMembersFromParse()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newMembersDataReceived", name: "receivedMembersDataFromServer", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
