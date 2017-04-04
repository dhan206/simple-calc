//
//  main.swift
//  SimplCalc
//
//  Created by Derek Han on 4/3/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import Foundation

print("Enter an expression separated by returns")
print("or enter \"help\" for more options:")
var continute: Bool = true;
let operators = ["+", "-", "*", "/", "%"]

while continute {
    var response = readLine(strippingNewline: true)
    response = response?.trimmingCharacters(in: NSCharacterSet.whitespaces)
    if response != nil {
        if (response == "help") { // help menu
            print("")
            print("HELP MENU")
            print("To use the \"count\" operation, enter any amount of numbers followed by the operation \"count\" and hit enter.")
            print("Example: 1 4 3 5 3 count")
            print("")
            print("To use the \"average\" operation, enter the numbers you wish to find the average of followed by the operation \"avg\" and hit enter.")
            print("Example: 1 4 3 5 3 avg")
            print("")
            print("To use the \"factorial\" operation, enter a single number followed by the operation \"fact\" and hit enter.")
            print("Example: 5 fact");
            print("")
            print("Math operators include \"+\", \"-\", \"*\", \"/\", and \"%\". Input your first number then hit enter. Input an operator then hit enter. Input your second number then hit enter.")
            print("Example:")
            print("15")
            print("*")
            print("10")
            print("")
            print("To exit, type \"exit\" and hit enter.")
            print("Example: exit")
            print("")
        } else if (response == "exit") { // exit the program
            continute = false;
        } else if (response?.hasSuffix("count"))! { // count operator
            let splitArray = response!.characters.split(separator: " ")
            print("Count: \(splitArray.count - 1)")
        } else if (response?.hasSuffix("avg"))! { // average operator
            let splitArray = response!.characters.split(separator: " ").map(String.init)
            if splitArray.count < 2 {
                print("Invalid input for the \"average\" operator. Type \"help\" for help.")
            } else {
                let total = splitArray.flatMap{ Double($0) ?? 0 }.reduce(0, +)
                print("Avg: \(total / (Double)(splitArray.count - 1))")
            }
        } else if (response?.hasSuffix(("fact")))! { // factorial operator
            let splitArray = response!.characters.split(separator: " ").map(String.init)
            if splitArray.count != 2 {
                print("Invalid input for the \"factorial\" operator. Type \"help\" for help.")
            } else {
                let number = splitArray.flatMap{ Int($0) ?? 0 }.reduce(0, +)
                if number < 21 {
                    var total = 1
                    for i in 1..<number+1 {
                        total = total * i;
                    }
                    print("\(number) factorial: \(total)")
                } else {
                    print("Sorry, unable to calculate factorial of a number greater than 20")
                }
            }
        } else {
            if UInt(response!) != nil { // first input must be a number
                var firstNum = Double(response!)!
                var response2 = readLine(strippingNewline: true)
                response2 = response2?.trimmingCharacters(in: NSCharacterSet.whitespaces)
                if response2 != nil && operators.contains(response2!) { // second input must be a valid math operator
                    var mathOperator = response2!
                    var response3 = readLine(strippingNewline: true)
                    response3 = response3?.trimmingCharacters(in: NSCharacterSet.whitespaces)
                    if UInt(response3!) != nil { // third input must be number
                        var secondNum = Double(response3!)!
                        if mathOperator == "%" { // mod operator
                            print("Result: \(firstNum.truncatingRemainder(dividingBy: secondNum))")
                        } else { // addition, subtraction, multiplication, and division operators
                            var equation = String(firstNum)
                            equation += mathOperator
                            equation += String(secondNum)
                            let expn = NSExpression(format: equation)
                            print("Result: \(String(describing: expn.expressionValue(with: nil, context: nil)!))")
                        }
                    } else {
                        print("You did not enter a valid number. Type \"help\" for help.")
                    }
                } else {
                    print("You did not enter a valid operator. Type \"help\" for help.");
                }
            } else {
                print("You did not enter a valid number. Type \"help\" for help.")
            }
        }
        print("")
    }
}

print("Thanks for using SimplCalc created by Derek Han")

