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


//Solution to Wednesday's Coding Challenge: 




