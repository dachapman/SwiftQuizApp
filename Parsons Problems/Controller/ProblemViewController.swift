//
//  ProblemViewController.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/28/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import UIKit

//  for passing problem information back to the quizviewcontroller
protocol QuizStatusHelper {
    func sendProblemStatusToQuiz(currentProblem: Problem, statusToSend: Bool)
}

class ProblemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    // MARK: properties
    @IBOutlet weak var problemPercentCorrect: UILabel!
    @IBOutlet weak var problemInstructions: UILabel!
    
    var quizStatusDelegate : QuizStatusHelper?
    
    // this is defined in QuizVC as the current problem student selected
    var problem : ParsonsProblemQuestion? = nil
    
    // property observer
    @IBOutlet weak var problemCollectionView: UICollectionView! {
        didSet {
            // for collectionview
            problemCollectionView.delegate = self
            problemCollectionView.dataSource = self
            
            // for dragging and dropping items in collectionview
            problemCollectionView.dragDelegate = self
            problemCollectionView.dropDelegate = self
            problemCollectionView.dragInteractionEnabled = true
         }
    }
    
    @objc func interfaceRotated() {
        guard let flowLayout = problemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(interfaceRotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        problemInstructions.text = problem?.parsonProblemInstructions
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    //MARK: Methods
    @IBAction func gradeProblem(_ sender: UIButton) {
        problem?.gradeProblem()
        
        if let percentCorrect = problem?.currentScore {
            problemPercentCorrect.text = String(format: "%.2f", percentCorrect)
            
            if percentCorrect == 100.00 {
                // if student achieves 100%, question is complete
                problem?.questionComplete = true
                
                // use: https://icanhazdadjoke.com/api
                // to get the joke to present on an alert
                parseJokeJSON(studentSucceeded: true)
                
                
            } else {
                // display alert but do not show a joke
                parseJokeJSON(studentSucceeded: false)
            }
        }
        
        // send completion status to Quiz
        guard let prob = problem else { return }
        
        // prob exists, so tell the QuizVC that the current problem "prob" is
        // completed and should get a checkmark after it in the tableview listing
        quizStatusDelegate?.sendProblemStatusToQuiz(currentProblem: prob, statusToSend: prob.questionComplete)
    
    }
    
    
    // MARK: - Joke API
    //  get random joke to present to student via alert
    //  use: https://icanhazdadjoke.com/api
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    
    func parseJokeJSON(studentSucceeded: Bool) {
        let urlPath = "https://icanhazdadjoke.com/"

        // if studentSucceeded on problem, then grab a joke to present on alert
        if studentSucceeded {
            // convert string to URL
            guard let endpoint = URL(string: urlPath) else {
                print("Error creating endpoint")
                return
            }

            var request = URLRequest(url: endpoint)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let userAgent = "My Library (https://github.com/dachapman)"


            // perform HTTP GET requests to retrieve data from servers to memory
            request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }

                    // parse JSON from Joke API - convert into a dictionary
                    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSDictionary else {
                        throw JSONError.ConversionFailed
                    }

                    if let joke = json["joke"] {

                        // Keep UI on main queue
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Congratulations!!\n", message: "\(joke)", preferredStyle: .alert)
                            let goToNextProblem = UIAlertAction(title: "Dismiss", style: .default)

                            alert.addAction(goToNextProblem)
                            self.present(alert, animated: true)
                        }
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error as NSError {
                    print(error.debugDescription)
                }
                }.resume()
        } else {
            
            // student did not complete question correctly and won't receive a joke!
            let alert = UIAlertController(title: "Good Try!!\n", message: "Your answer was not quite right.  Try again.", preferredStyle: .alert)
            let goToNextProblem = UIAlertAction(title: "Dismiss", style: .default)

            alert.addAction(goToNextProblem)

            // present the alert
            self.present(alert, animated: true)

        }

    }
    

    
    // MARK:  Collection View setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let codeArray = problem?.codeSnippets else {
            return 0
        }
        return codeArray.count
    }
    
    // deal with accessible font
    private var font: UIFont {
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(16.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "codeSnippetIdentifier", for: indexPath as IndexPath)
        
        if let codeCell = cell as? ProblemCell {
            if let codeSnip = problem?.codeSnippets[indexPath.item] {
                // set up text (code snippets) and color for collection view item
                codeCell.cellLabel.attributedText = NSAttributedString(string: codeSnip)
                codeCell.layer.cornerRadius = 8
                codeCell.backgroundColor = UIColor.lightGray
            }
        }
        return cell
    }
    
    // set up cell size so it dynamically adjusts
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCellsInRow = 1
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numCellsInRow - 1)) + 16
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numCellsInRow))
        
        return CGSize(width: size, height: 40)
    }
    
    // MARK:  Collection view "drag and drop" setup  (local only)
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        return dragItems(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        
        return dragItems(at: indexPath)
    }
    
    // strings to be dragged
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        
        if let cellString = (problemCollectionView.cellForItem(at: indexPath) as? ProblemCell)?.cellLabel.text {
            
            let attributes = [NSAttributedString.Key.font: font]
            let attributedString = NSAttributedString(string: cellString, attributes: attributes)
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedString))
            dragItem.localObject = attributedString
            return [dragItem]
            
        } else {
            return []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        for item in coordinator.items {
            // local drop
            
            if let sourceIndexPath = item.sourceIndexPath {
                if let attributedString = item.dragItem.localObject as? NSAttributedString {

                    // do all the following as one operation to keep everything in sync
                    collectionView.performBatchUpdates({
                        
                        // update model
                        problem?.codeSnippets.remove(at: sourceIndexPath.item)
                        problem?.codeSnippets.insert(attributedString.string, at: destinationIndexPath.item)
                        
                        // update collectionview
                        problemCollectionView.deleteItems(at: [sourceIndexPath])
                        problemCollectionView.insertItems(at: [destinationIndexPath])
                        
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
