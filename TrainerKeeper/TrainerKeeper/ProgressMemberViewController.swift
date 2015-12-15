//
//  ProgressMemberViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ProgressMemberViewController: UIViewController {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMemberArray :[PFObject?] = []
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
        let memberCell = tableView.dequeueReusableCellWithIdentifier("memberCell", forIndexPath:
            indexPath) as UITableViewCell
        let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
        let currentMember = filteredArray[indexPath.row]
        
        memberCell.textLabel!.text = "\(currentMember["firstName"] as! String!) \(currentMember["lastName"] as! String!)"
        
        return memberCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMemberSelect" {
            let destController = segue.destinationViewController as! ProgressSelectViewController
            
            if let indexPaths = membersTableView.indexPathsForSelectedRows {
                for indexPath in indexPaths {
                    let filteredArray = filterMemberByClass(dataManager.classesDataArray[indexPath.section])
                    let selectedMember = filteredArray[indexPath.row]
                    selectedMemberArray.append(selectedMember)
                    membersTableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
                destController.selectedMemberArray = selectedMemberArray
            }
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 255/255, green: 104/255, blue: 29/255, alpha: 1)
        dataManager.fetchExercisesFromParse()
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedMemberArray.removeAll()
        dataManager.workoutDataArray.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
