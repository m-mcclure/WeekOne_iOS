//: Playground - noun: a place where people can play

import UIKit

//Solution to Monday's Coding Challenge: Write a function that reverses an array.

var moreLetters = ["a", "e", "i", "o", "u", "y"]

func reversi(letters: [String]) -> [String] {
  var reversedArray = [String]()
  
  for letter in letters {
    reversedArray.insert(letter, atIndex: 0)
  }
  return reversedArray
}

reversi(moreLetters)


//Solution to Tuesday's Coding Challenge: Fizz Buzz.

var i = 0

for (i = 1; i < 101; i++){
  if (i % 3 == 0) && (i % 5 == 0) {
    println("fizzbuzz")
  } else if i % 3 == 0 {
    println("fizz")
  } else if i % 5 == 0 {
    println("buzz")
  } else {
    println(i)
  }
}


//Solution to Wednesday's Coding Challenge: Return the number of times that the string "hi" appears anywhere in the given string.

var sampleText = "Hi, Jonah. Hi, Milton. Are we still on for lunch at Shilla? Hello, Caroline. Say hi to your mother for me. Is she still working at the Hilton? Howdy, Jason. Hi, Mary. Hello, Justin. Yo, Thomas! Say hi to the captain for me! Umm, hi. Hello? Hi!"

func lookForHi(textToSearch: String) -> Int {
  let textToSearchArray = Array(textToSearch)
  var hiCount : Int = 0
  for character in textToSearchArray {
    if character == "h" || character == "H" {
      if let charIndex = find(textToSearchArray, character) {
        let charPosition = distance(textToSearchArray.startIndex, charIndex)
        if textToSearchArray[charPosition + 1] == "i" || textToSearchArray[charPosition + 1] == "I" {
          hiCount++
        }
      }
    }
  }
  return hiCount
}

lookForHi(sampleText)


//Solution to Thursday's coding challenge: Given a string, return a version where all the "x" have been removed. Except an "x" at the very start or end should not be removed.

let stringSample = "X-men are mutants, not extraterrestrials. Depending on which side they're on, they go to extreme lengths to either defend or exterminate the human race. Are there any X-men who have x-ray vision, like Superman? I can't think of any examples... Are there any X-men who can play tenor sax? Or weild an ax? Or like that Kevin Spacey movie, K-PAX?"

func removeEveryXExceptFirstAndLast(string: String) -> String {
  var stringAsArray = Array(string)
  let stringLength = stringAsArray.count
  let firstChar = stringAsArray[0]
  let lastCharIndex = Int(stringLength - 1)
  let lastChar = stringAsArray[lastCharIndex]
  stringAsArray.removeAtIndex(0)
  let newLastCharIndex = Int(lastCharIndex - 1)
  stringAsArray.removeAtIndex(newLastCharIndex)
  
  for character in stringAsArray {
    if character == "X" || character == "x" {
      if let charIndex = find(stringAsArray, character) {
        let charPosition = distance(stringAsArray.startIndex, charIndex)
        stringAsArray.removeAtIndex(charPosition)
      }
    }
  }

  let arrayBackToString = String(stringAsArray)
  let stringToReturn = "\(firstChar)" + arrayBackToString + "\(lastChar)"
 
  return stringToReturn
}

removeEveryXExceptFirstAndLast(stringSample)







