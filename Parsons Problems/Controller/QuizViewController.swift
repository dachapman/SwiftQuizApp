//
//  QuizViewController.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuizStatusHelper {
    
    // MARK: properties
    @IBOutlet weak var quizTableView: UITableView!
    @IBOutlet weak var percentageComplete: UILabel!
    
    // create instance of the quiz data
    let dataForQuiz = DataHelper()
    
    var numProblemsInQuiz = 0
    var currentProblem : Problem? = nil
    
    // MARK: methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // populate the quiz
        dataForQuiz.prepareQuiz()
        
        self.quizTableView.delegate = self
        self.quizTableView.dataSource = self
        
        // count number of quizzes for use in setting up tableview
        if let numProblems = dataForQuiz.quiz?.allQuestions.count {
            numProblemsInQuiz = numProblems
        } else {
            numProblemsInQuiz = 0
        }
        
        determinePercentOfQuizCompleteAndUpdateUI()
        
        // quizTableView layout info
        quizTableView.estimatedRowHeight = 100.0
        quizTableView.rowHeight = UITableView.automaticDimension

    }
    
    // implement the protocol for the ProblemViewController to get information about problem completion
    // status (student got a 100%) from the grading method for the problem
    func sendProblemStatusToQuiz(currentProblem: Problem, statusToSend: Bool) {
        currentProblem.questionComplete = statusToSend
        
        determinePercentOfQuizCompleteAndUpdateUI()

    }
    
    func determinePercentOfQuizCompleteAndUpdateUI() {
        // display percent of quiz that is complete based on # problems correct
        if let percent = dataForQuiz.quiz?.percentComplete {
            percentageComplete.text = String(format: "%.2f", percent)
        }
        quizTableView.reloadData()
    }
    
    // MARK: tableview setup
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numProblemsInQuiz
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as? QuizCell else {
            fatalError("Dequeued cell is not an instance of QuizCell.")
        }
        if let quizTitle = dataForQuiz.quiz?.allQuestions[indexPath.row].title {
            cell.nameLabel.text = quizTitle
        } else {
            cell.nameLabel.text = "no value"
        }
        
        if let problemComplete = dataForQuiz.quiz?.allQuestions[indexPath.row].questionComplete {
            if problemComplete {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProblemSegue" {
            
            guard let problemVC = segue.destination as? ProblemViewController else {
                return
            }
            guard let indexPath = self.quizTableView.indexPathForSelectedRow else {
                return
            }
            guard let prob = dataForQuiz.quiz?.allQuestions[indexPath.row] as? ParsonsProblemQuestion else {
                return
            }
            
            // pass the problem and delegate value to the problem view controller
            problemVC.problem = prob
            problemVC.quizStatusDelegate = self
        }
    }
    

}
