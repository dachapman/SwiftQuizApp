## Swift Quiz App
An app to assess a student's proficiency using Swift to solve common CS problems:

Two pages:

1. Quiz Page

  * TableView showing a list of quiz problems
  
  * Score label showing current student's score on quiz
  
2. Problem Page

  * UICollectionView with dragable cells (long-tap) to order the code snippets into the correct working order
  
  * Button to grade the current configuration of code snippets
  
To Do:

  * Write quiz and problems to Documents directory as JSON to persist the state of the student's quiz
  
  * URLSession and Codeable protocols for Quiz and Problem structs and classes
    
  * Ensure accessibility for enlarged fonts via UIFont Metrics
  
