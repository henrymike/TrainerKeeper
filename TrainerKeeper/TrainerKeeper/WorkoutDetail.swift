//
//  WorkoutDetail.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/8/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class WorkoutDetail: NSObject {
    
    var exercise        :PFObject!
    var exerciseName    :String!
    var member          :PFObject!
    var memberFirstName :String!
    var memberLastName  :String!
    var exerciseReps    :Int!
    var exerciseMeasure :Double!
    var exerciseSeconds :Double!

}
