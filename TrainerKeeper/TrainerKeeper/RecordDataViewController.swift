//
//  RecordDataViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class RecordDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMember :PFObject?
//    var recordMemberArray :[PFObject?] = []
    var recordDataArray :[PFObject?] = []
    @IBOutlet weak var recordTableView :UITableView!

    
    
    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return recordDataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordDataArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let record2DataArray = ([recordDataArray] as! NSArray)
//        return (record2DataArray[section] as! String)
        
        return (recordDataArray[section]!["name"] as! String)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let exerciseCell = tableView.dequeueReusableCellWithIdentifier("recordExcerciseCell", forIndexPath:
//            indexPath) as! RecordTableViewCell
//        let recordExercise = recordDataArray[0]
//        exerciseCell.excerciseLabel.text = "\(recordExercise!["name"] as! String)"
        
        let memberCell = tableView.dequeueReusableCellWithIdentifier("recordMemberCell", forIndexPath: indexPath) as! RecordTableViewCell
        let recordMember = selectedMember
        memberCell.memberLabel.text = "\(recordMember!["firstName"] as! String!) \(recordMember!["lastName"] as! String!)"

        return memberCell
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Segue Array: \(recordDataArray)")
        print("Segue Member: \(selectedMember)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
