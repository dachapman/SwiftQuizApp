//
//  DataHelper.swift
//  Parsons Problems
//
//  Created by Dee Chapman on 3/27/19.
//  Copyright © 2019 Dee Chapman. All rights reserved.
//

import Foundation

//class DataHelper: Codable {
class DataHelper {

    var quiz: Quiz? = nil
    
    func prepareQuiz() {
  
        //  Eventually modify this to read a set of questions from a text file, or a JSON file
        let parsonsProblemString001 = """
        Print a triangle
        Use long tap to drag statements in correct order. Order statements to print a triangle of stars, point at the top
        print("    *    ")
        print("   ***   ")
        print("  *****  ")
        print(" ******* ")
        print("*********")
        """
        
        let parsonsProblemString002 = """
        Print an upside-down triangle
        Use long tap to drag statements in correct order. Order statements to print an upside-down triangle of starts, point at the bottom
        print("*********")
        print(" ******* ")
        print("  *****  ")
        print("   ***   ")
        print("    *    ")
        """
        
        let parsonsProblemString003 = """
        For-loop counting
        Use long tap to drag statements in correct order.  Use a for-loop to print integers from 3 to 17
        for i in 3 ... 17 {
            print(i)
        }
        """
        
        let parsonsProblemString004 = """
        For-loop even numbers
        Use long tap to drag statements in correct order.  Use a for-loop to print even numbers from 7 to 28
        for possible in 7 ... 28 {
            if possible % 2 == 0 {
                print(possible)
            }
        }
        """
        
        let parsonsProblemString005 = """
        For-loop squares
        Use long tap to drag statements in correct order.  Use a for-loop to print the numbers and squares of numbers from 0 to 10
        for i in 0 ... 10 {
            let squareOfNumber = i * i
            print("number is \\(i); square of \\(i) is \\(squareOfNumber)")
        }
        """
        
        let parsonsProblemString006 = """
        Recursive reverse string
        Use long tap to drag statements in correct order.  Write a recursive function that returns a string in reverse sequence of the original
        func reverse(_ ss: String) -> String {
            if ss.count == 0 {
                return ""
            } else {
                var tmpString = ss
                let lastChar = tmpString()
                return String(lastChar) + reverse(tmpString)
            }
        }
        """

        let parsonsProblemString007 = """
        Sum function
        Use long tap to drag statements in correct order.  Write a function that returns the sum of all elements in an array of integers.  Hint: define 'sum' within your function.
        let anArray = [17, 25, 42, 3, 16]
        func sumOf(array: [Int]) -> Int {
            var sum = 0
            for anInt in array {
                sum += anInt
            }
            return sum
        }
        """
        
        let parsonsProblemString008 = """
        Minimum of array
        Use long tap to drag statements in correct order.  Print the 'index' of the minimum value of all elements in an array of Doubles.  Hint: Define 'thisArray' before 'minIndex'.
        let thisArray = [15.7, 23.9, -7.1, -65.4, 18.2]
        var minIndex = 0
        for (index, element) in thisArray.enumerated() {
            if element < thisArray[minIndex] {
                minIndex = index
            }
        }
        print("index of minimum is \\(minIndex)")
        """
        
        let parsonsProblemString009 = """
        Popular songs
        Use long tap to drag statements in correct order.  Print most popular song title where the 1st element of the numListens array corresponds to the 1st element of the song array, etc.  Hint: define in order: 'song', 'numListens', 'indexMostPopSong'.
        let song = ["Closer", "One Dance", "Shape of You"]
        let numListens = [57241, 24827, 99424]
        var indexMostPopSong = 0
        for i in 0 ..< song.count {
            if numListens[i] > numListens[indexMostPopSong] {
                indexMostPopSong = i
            }
        }
        print("Title of most popular song is \\(song[indexMostPopSong])")
        """
        
        let parsonsProblemString0010 = """
        Sample Title
            Use long tap to drag statements in correct order.  Specific instructions go here.
            c1:1
            c1:2
            c1:3
            c1:4
            c1:5
            c1:6
        """
        
        let pp1 = ParsonsProblemQuestion(questionInputString: parsonsProblemString001)
        let pp2 = ParsonsProblemQuestion(questionInputString: parsonsProblemString002)
        let pp3 = ParsonsProblemQuestion(questionInputString: parsonsProblemString003)
        let pp4 = ParsonsProblemQuestion(questionInputString: parsonsProblemString004)
        let pp5 = ParsonsProblemQuestion(questionInputString: parsonsProblemString005)
        let pp6 = ParsonsProblemQuestion(questionInputString: parsonsProblemString006)
        let pp7 = ParsonsProblemQuestion(questionInputString: parsonsProblemString007)
        let pp8 = ParsonsProblemQuestion(questionInputString: parsonsProblemString008)
        let pp9 = ParsonsProblemQuestion(questionInputString: parsonsProblemString009)
        let pp10 = ParsonsProblemQuestion(questionInputString: parsonsProblemString0010)
        
        self.quiz = Quiz(allQuestions: [pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10])
    }
    
}
