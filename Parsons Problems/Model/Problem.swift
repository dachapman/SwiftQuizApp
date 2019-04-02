//
//  Problem.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import Foundation

// this is an abstract class that represents a Quiz problem.  It's used to create subclasses
// like Parsons Problems, multiple choice, and true/false.

class Problem {
    var title : String = ""
    var questionComplete : Bool = false
    var currentScore : Double = 0.0
    
    var description : String {
        var desc : String = "Problem: \n"
        desc += "Title: \(title)\n"
        desc += "Complete: \(questionComplete)\n"
        desc += "Score: \(currentScore)\n\n"
        return desc
    }
}
