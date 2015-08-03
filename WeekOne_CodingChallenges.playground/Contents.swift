//: Playground - noun: a place where people can play

import UIKit

//Solution to Monday's Coding Challenge: Write a function that reverses an array.

var moreLetters = ["a", "e", "i", "o", "u", "y"]

func reversi(letters: [String]) -> [String] {
  var reversedArray = [String]()
  var i = letters.count - 1
  
  for letter in letters {
    let letterHolder = letters[i]
    reversedArray.append(letterHolder)
    i--
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



