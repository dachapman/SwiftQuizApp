//
//  Quizlet.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import Foundation

// a Quizlet is one puzzle of a bigger Quiz
struct Question {
    var title : String = ""
    var instructions : String = ""
    var questionComplete : Bool = false
    var currentScore : Double = 0.0

    
    var codeSnippets : [String] = []
    var codeSolution : [String] = []
    
    init(questionInputString : String) { // will need to do error checking here
        
        // input string should include:
        // line 0: Title
        // line 1: Instructions
        // line 2+: Code snippets ordered correctly
        
        let splitQuizletArray = questionInputString.split(separator: "\n")
        title = String(splitQuizletArray[0])
        instructions = String(splitQuizletArray[1])
        
        for i in 2..<splitQuizletArray.count - 2 {
            codeSolution.append(String(splitQuizletArray[i]))
        }
        
        // randomize the order of the code snippets for presentation to the student
        codeSnippets = codeSolution.shuffled()
    }
    
    var description : String {
        
        var desc = ""
        print("Title: \(title)\n  Instructions: \(instructions)\n  Score: \(currentScore)\n  Complete: \(questionComplete)\n")
        print("Code solution:\n")
        for code in codeSolution {
            print("\(code)\n")
        }
        return desc
    }
    
}
