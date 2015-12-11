//
//  ProgressDisplayViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

//
//  ProgressDisplayViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/11/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ProgressDisplayViewController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedMemberArray :[PFObject?] = []
    var selectedDataArray :[PFObject?] = []
    @IBOutlet weak var progressGraphView :BEMSimpleLineGraphView!
    
    
    
    //MARK: - Graph View Methods
    
//    func filterDataByMember(group: PFObject) -> [PFObject] {
//        let filteredData = selectedDataArray.filter({$0["member"] as! PFObject == group})
//        return filteredData
//    }
    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        //        let filteredArray = filterDataByMember(dataManager.exercisesDataArray)
        //        return filteredArray.count
        return 22
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return 34
    }
    
    
    
    //MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected Member Array: \(selectedMemberArray)")
        print("Selected Data Array: \(selectedDataArray)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

