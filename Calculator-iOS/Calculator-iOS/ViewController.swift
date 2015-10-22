//
//  ViewController.swift
//  Calculator-iOS
//
//  Created by Conrad Zimney on 10/21/15.
//  Copyright © 2015 Conrad Zimney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screen: UILabel!
    
    var num1Expression : String = ""
    var num2Expression : String = ""
    var operation : String = ""
    var num1 : Int = 0
    var num2 : Int = 0
    var typingNum1 : Bool = true
    var typingNum2 : Bool = false
    var typingExtended : Bool = false
    var numList : [Int] = [Int]()
    
    @IBAction func numberButton(sender: UIButton) {
        if typingNum1 {
            num1Expression += sender.currentTitle!
            screen.text = num1Expression
        }
        if typingNum2 {
            num2Expression += sender.currentTitle!
            screen.text = num2Expression
        }
    }

    @IBAction func operationButton(sender: UIButton) {
        if typingNum1 {
            typingNum1 = false
            typingNum2 = true
        }
        operation = sender.currentTitle!
        screen.text = operation
    }
    
    @IBAction func extendedOperationButton(sender: UIButton) {
        typingExtended = true
        operation = sender.currentTitle!
        if operation == "count" {
            num1 = Int(num1Expression)!
            numList.append(num1)
            num1Expression = ""
            screen.text = "count"
        } else if operation == "avg" {
            num1 = Int(num1Expression)!
            numList.append(num1)
            num1Expression = ""
            screen.text = "avg"
        } else if operation == "fact" {
            screen.text = "fact"
            num1 = Int(num1Expression)!
            num1Expression = ""
            evaluate()
            num1 = 0
            operation = ""
        }
    }
    
    @IBAction func equalsButton(sender: UIButton) {
        typingNum1 = true
        typingNum2 = false
        num1 = Int(num1Expression)!
        if num2Expression != "" {
            num2 = Int(num2Expression)!
        }
        if typingExtended {
            numList.append(num1)
        }
        evaluate()
        num1 = 0
        num2 = 0
        num1Expression = ""
        num2Expression = ""
        operation = ""
        numList.removeAll()
        typingExtended = false
    }
    
    func evaluate() -> Void {
        switch operation {
        case "+":
            screen.text = "\(num1 + num2)"
        case "-":
            screen.text = "\(num1 - num2)"
        case "*":
            screen.text = "\(num1 * num2)"
        case "/":
            screen.text = "\(num1 / num2)"
        case "%":
            screen.text = "\(num1 % num2)"
        case "avg":
            var sum = 0
            for var i = 0; i < numList.count; i++ {
                sum += numList[i]
            }
            let avg = Float(sum) / Float(numList.count)
            screen.text = "\(avg)"
        case "count":
            screen.text = "\(numList.count)"
        case "fact":
            var fact = 1
            for var i = 1; i <= num1; i++ {
                fact *= i
            }
            screen.text = "\(fact)"
        default:
            screen.text = "Please enter # operation #"
        }
    }
    
}

