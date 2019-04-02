//
//  Quiz.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import Foundation

struct Quiz {

    var allQuestions : [Problem] = []
    
    var percentComplete : Double {
        let totNumQuestions = allQuestions.count
        var numQuestionsComplete = 0
        for question in allQuestions {
            if question.questionComplete {
                numQuestionsComplete += 1
            }
        }
        return 100.0 * Double(numQuestionsComplete) / Double(totNumQuestions)
    }
    
    // compute score for Quiz - use computed property = sum of all the scores of all the questions in the quiz
    
    var description : String {
        var desc = ""
        desc += "Complete: \(percentComplete) %\n"
        for question in allQuestions {
            desc += question.description
        }
        return desc
    }
    
}

