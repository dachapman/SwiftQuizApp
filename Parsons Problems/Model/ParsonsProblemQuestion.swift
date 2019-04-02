//
//  ParsonsProblemQuestion.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import Foundation

class ParsonsProblemQuestion : Problem {
    
    var codeSnippets : [String] = []
    var codeSolution : [String] = []
    var parsonProblemInstructions: String = ""
    
    //  Eventually turn this into a failable initializer that will return nil if a question cannot
    //  be created, or a valid question if there are three or more lines of text, for example.
    
    init(questionInputString : String) { // will need to do error checking here
        
        super.init()
        // input string should include:
        // line 0: Title
        // line 1: Instructions
        // line 2+: Code snippets ordered correctly (solution)
        
        let splitArray = questionInputString.split(separator: "\n")
        title = String(splitArray[0])
        parsonProblemInstructions = String(splitArray[1])
        
        for i in 2..<splitArray.count {
            let code = String(splitArray[i])
            codeSolution.append(code)
        }
        // randomize the order of the code snippets for presentation to the student
        codeSnippets = codeSolution.shuffled()
        while codeSnippets == codeSolution {
            codeSnippets = codeSnippets.shuffled()
        }
    }
    

 
    //  Create a nicely formatted text representation of a question
    override var description : String {
        var desc = "Parsons Problem:\n"
        desc += "Title: \(title)\n"
        desc += "Instructions: \(parsonProblemInstructions)\n"
        desc += "Score: \(currentScore)\n"
        desc += "Complete: \(questionComplete)\n"
        desc += "Code solution:\n"
        for code in codeSolution {
            desc += "     \(code)\n"
        }
        return desc
    }
    
   //  A completed question will be assigned a grade that is the ratio of the number of instructions
   //  in the correct order vs. the total number of instructions to be ordered
   func gradeProblem() {
        let numberOfSnippets : Double = Double(codeSnippets.count)
        var numberOfSnippetsCorrectlyPlaced : Double = 0.0
        for i in 0..<codeSnippets.count {

            if codeSnippets[i] == codeSolution[i] {
                numberOfSnippetsCorrectlyPlaced += 1.0
            }
        }
        currentScore = 100.0 * numberOfSnippetsCorrectlyPlaced / numberOfSnippets
    }
}

