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
    var detailTitle = ""
    
    
    
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
        let memberCell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath:
            indexPath) as UITableViewCell
        let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
        let currentMember = filteredArray[indexPath.row]
        
        memberCell.textLabel!.text = "\(currentMember["firstName"] as! String!) \(currentMember["lastName"] as! String!)"
        
        return memberCell
    }
    
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            let memberToDelete = dataManager.membersDataArray[indexPath.row]
//            memberToDelete.deleteInBackground()
//            dataManager.fetchMembersFromParse()
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberEdit" {
            let destController = segue.destinationViewController as! MembersDetailViewController
            let indexPath = membersTableView.indexPathForSelectedRow!
            let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
            let selectedMember = filteredArray[indexPath.row]
            detailTitle = "\(selectedMember["firstName"] as! String) \(selectedMember["lastName"] as! String)"
            destController.selectedMember = selectedMember
            destController.detailTitle = detailTitle
            membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    func newMembersDataReceived() {
        membersTableView.reloadData()
        
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 13/255, green: 117/255, blue: 204/255, alpha: 1)
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
