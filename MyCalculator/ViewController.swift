//
//  ViewController.swift
//  MyCalculator
//
//  Created by student on 2/26/20.
//  Copyright © 2020 Samir. All rights reserved.
//

import UIKit
import Foundation

func IsDelimeter(_ x: String) -> Bool{
        if(x == "="){
            return true
        }
        return false
    }

    func Round(_ value: Double, _ toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }

    func IsOperator(_ x: String) -> Bool{
        switch x {
            case "+":
                return true
            case "-":
                return true
            case "/":
                return true
            case "*":
                return true
            case "^":
                return true
            default:
                return false
        }
//        return false
    }

    func IsBracket(_ x: String) -> Bool {
        switch x {
        case "(":
            return true
        case ")":
            return true
        default:
            return false
        }
    }

    func GetPriority(_ x: String) -> Int{
        switch x {
            case "(":
                return 0
            case ")":
                return 1
            case "+":
                return 2
            case "-":
                return 2
            case "*":
                return 4
            case "/":
                return 4
            case "^":
                return 5
            default:
                return 6
        }
    }

    func IsDigit(_ x: Character) -> Bool {
        switch x {
            case "1":
                return true
            case "2":
                return true
            case "3":
                return true
            case "4":
                return true
            case "5":
                return true
            case "6":
                return true
            case "7":
                return true
            case "8":
                return true
            case "9":
                return true
            case "0":
                return true
            default:
                return false
        }
    }

    func IsNumber(_ x: String) -> Bool{
        if( Int(x) != nil){
                return true
            }else if( Double(x) != nil){
                return true
            }
            return false
    }

    func IsDoubleOrInt(_ x: String) -> String {
        let enterArray = Array(x)
        var count: Int = 0
        let len: Int = x.count
        var equation: Array<String> = []
        var result: String = ""
        var number: String = ""
        var char: String = ""
        for var i in enterArray{
            if(IsDigit(i)){
                number += String(i)
            }else{
                char = String(i)
                if(number != ""){
                    equation.append(number)
                }
                equation.append(char)
                number = ""
                char = ""
            }
            if(count == len - 1 && number != ""){
                equation.append(number)
            }
            count += 1
        }

        if(equation.last == "0"){
            for j in equation {
                if(j == "."){
                    break
                }
            result += j
            }
        }else{
            for j in equation {
                result += j
            }
        }

        return result
    }

    func Calculate (_ x: String ) -> String{
        let arranged: Array<String> = Arrange(x)
        let polishExpression: Array<String> = GetExpression(arranged)
        let counted: String = Counting(polishExpression)
        let finalResult: String = IsDoubleOrInt(counted)
        return finalResult
    }

    func Arrange(_ x: String) -> Array<String> {
        var count = 0
        let enterArray = Array(x)
        var equation: Array<String> = []
        var number: String = ""
        var char: String = ""
        let len = enterArray.count
//        var temp: String = ""
        for var i in enterArray{
            count += 1
            if(IsDigit(i) || i == "."){
                number += String(i)
            }else{
                char = String(i)
                if(number != ""){
                    equation.append(number)
                }
                equation.append(char)
                number = ""
                char = ""
            }
            if(count == len && number != ""){
                equation.append(number)
            }
//            temp = String(i)
        }
        return equation
    }

    func GetExpression(_ x: Array<String> ) -> Array<String> {
        var result: Array<String> = []
        var operStack: Array<String> = []
        var count = 0
        let len = x.count
        // var str: String = ""
        while count <  len{
            if(IsDelimeter(x[count])){
                break
            }
            if(IsNumber(x[count])){
                if( !IsDelimeter(x[count]) && !IsOperator(x[count])) {
                    result.append(x[count])
                    if(count == len){
                        break
                    }
                }
            }
            if(IsOperator(x[count]) || IsBracket(x[count])){

                    if(x[count] == "("){
                        operStack.insert(x[count], at: 0)
                    } else if (x[count] == ")"){
                        var operators  = operStack[0]
                        
                        while operators != "(" {
                            result.append(operators)
                            if(operStack.count > 0){
                                operStack.remove(at: 0)
                                operators = operStack[0]
                            } else {
                                operators = ""
                            }
                            if(operStack[0] == "("){
                                if(operStack.count > 0){
                                     operStack.remove(at: 0)
                                }
                            }
                        }
                    }else{
                        if(operStack.count > 0){
                            if(GetPriority(x[count]) <= GetPriority(operStack[0])){
                                while operStack.count > 0{
                                    result.append(operStack[0])
                                    operStack.remove(at: 0)
                                }
                                operStack.insert(x[count], at: 0)
                            } else {
                                operStack.insert(x[count], at: 0)
                            }
                        } else {
                            operStack.insert(x[count], at: 0)
                        }
                    }
             
            }
            count += 1
        }

        while operStack.count > 0 {
            if(operStack[0] != "(" && operStack[0] != ")"){
                result.append(operStack[0])
                operStack.remove(at: 0)
            }else{
                operStack.remove(at: 0)
            }
        }
        return result
    }

    func Counting(_ x: Array<String> ) -> String{
        var math: Double = 0
        var result: String = ""
        var temp: Array<String> = []
        var count = 0
        let len = x.count

        while count < len {
            if(IsNumber(x[count])){
//                var y: Array<String>
                if (!IsDelimeter(x[count]) && !IsOperator(x[count]) && !IsBracket(x[count])) {
                    temp.insert(x[count], at: 0)
                    if(count == len){
                        break
                    }
                }

            } else if(IsOperator(x[count]) || IsBracket(x[count])) {
                let a: Double = Double(temp[0])!
                temp.remove(at: 0)
                let b: Double = Double(temp[0])!
                temp.remove(at: 0)
                
//                if(temp.count > 0){
//                    a = Double(temp[0])!
//                    temp.remove(at: 0)
//                }
//
//                if(temp.count > 0){
//                    b = Double(temp[0])!
//                    temp.remove(at: 0)
//                }
                
                switch x[count] {
                    case "+":
                        math = b + a
                        break
                    case "-":
                        math = b - a
                        break
                    case "*":
                        math = b * a
                        break
                    case "/":
                        math = b / a
                        break
                    case "^":
                        math = pow(b, a)
                        break
                    default:
                        math = 0
                }
                // var sss = String(math)
                temp.insert(String(math), at: 0)
            }
            count += 1
        }
        if(temp[0].count > 6){
            result = String(Round(Double(temp[0])!, 0.1))
//            return result
            if(temp[0].count > 6){
                result = String(Round(Double(temp[0])!, 0.01))
                return result
            }
        } else {
            result = temp[0]
            return result
        }
        return result
    }

func errorLabel (_ error: String, _ label: UILabel) {
        label.text = error
        label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }

func clearLabel (_ label: UILabel) {
    label.text = ""
}

class ViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var result: String = ""
    var temp: String = ""
    var error: String = ""
    var secondResult: String = ""
    var IsResult: Bool = false
    var tempNumber: String = ""
       
    
    @IBOutlet weak var labelMain: UILabel!
    
    @IBOutlet weak var labelSecond: UILabel!
    
    
    @IBAction func number0(_ sender: UIButton) {
        if(temp == "/"){
            tempNumber = "0."
            temp = "0."
            result += "0."
            labelMain.text = result
            clearLabel(labelSecond)
            return
        }else if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        } else if (temp == "0" && result == "0") {
            errorLabel("You can not write zero after zero", labelSecond)
            return
        } else if (temp == "") {
            tempNumber = "0."
            temp = "0."
            result += "0."
            labelMain.text = result
            clearLabel(labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "0"
        temp = "0"
        result += "0"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number1(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "1"
        temp = "1"
        result += "1"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number2(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "2"
        temp = "2"
        result += "2"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number3(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "3"
        temp = "3"
        result += "3"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number4(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "4"
        temp = "4"
        result += "4"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number5(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "5"
        temp = "5"
        result += "5"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number6(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "6"
        temp = "6"
        result += "6"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number7(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "7"
        temp = "7"
        result += "7"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number8(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "8"
        temp = "8"
        result += "8"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func number9(_ sender: UIButton) {
        if(temp == ")"){
            errorLabel("You can not write number after ')' symbol", labelSecond)
            return
        }
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        tempNumber += "9"
        temp = "9"
        result += "9"
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func charDot(_ sender: UIButton) {
        if(IsResult == true){
            result = ""
            labelMain.text = result
            IsResult = false
        }
        if(!IsNumber(temp)){
            tempNumber = "0."
            temp = "0."
            result += "0."
            labelMain.text = result
            clearLabel(labelSecond)
            return
        } else if (temp == ""){
           errorLabel("You can add dot only to numbers", labelSecond)
           return
        }
        if(tempNumber.contains(".")){
            errorLabel("You can not write two dots in one number", labelSecond)
            return
        }
        tempNumber += "."
        temp = "."
        result += "."
        labelMain.text = result
        clearLabel(labelSecond)
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        tempNumber = ""
        temp = ""
        result = ""
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func deleteOne(_ sender: UIButton) {
        // Delete last characater of the last number
        if(tempNumber.count > 1){
            tempNumber.remove(at: tempNumber.index(before: tempNumber.endIndex))
        } else if(tempNumber.count == 1){
            tempNumber = ""
        } else {
            tempNumber = ""
        }
        if(result.count > 1){
            result.remove(at: result.index(before: result.endIndex))
        } else if (result.count == 1) {
            result = ""
        }
        if(result.count == 0){
            temp = ""
        }else{
            temp = String(result.last!)
        }
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func actionPlus(_ sender: UIButton) {
        if(IsOperator(temp)){
            result.remove(at: result.index(before: result.endIndex))
            result += "+"
            labelMain.text = result
            temp = "+"
            return
        } else if (temp == "("){
            errorLabel("You can not write an operator after '(' symbol", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write an operator after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "+"
        result += "+"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func actionMinus(_ sender: UIButton) {
        if(IsOperator(temp)){
            result.remove(at: result.index(before: result.endIndex))
            result += "-"
            labelMain.text = result
            temp = "-"
            return
        }else if (temp == "("){
            errorLabel("You can not write an operator after '(' symbol", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write an operator after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "-"
        result += "-"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func actionMultiply(_ sender: UIButton) {
        if(IsOperator(temp)){
            result.remove(at: result.index(before: result.endIndex))
            result += "*"
            labelMain.text = result
            temp = "*"
            return
        }else if (temp == "("){
            errorLabel("You can not write an operator after '(' symbol", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write an operator after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "*"
        result += "*"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func actionDivide(_ sender: UIButton) {
        if(IsOperator(temp)){
            result.remove(at: result.index(before: result.endIndex))
            result += "/"
            labelMain.text = result
            temp = "/"
            return
        }else if (temp == "("){
            errorLabel("You can not write an operator after '(' symbol", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write an operator after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "/"
        result += "/"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func actionPow(_ sender: UIButton) {
        if(IsOperator(temp)){
            result.remove(at: result.index(before: result.endIndex))
            result += "^"
            labelMain.text = result
            temp = "^"
            return
        } else if (IsBracket(temp)){
            errorLabel("You can not write pow after brackets", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write an operator after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "^"
        result += "^"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func leftBracket(_ sender: UIButton) {
        if(IsNumber(temp)){
            errorLabel("You can not write '(' symbol after number", labelSecond)
            return
        } else if (IsBracket(temp)) {
           errorLabel("You can not write bracket after bracket", labelSecond)
           return
        } else if (temp == "^"){
            errorLabel("You can not write brackets after pow", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write a bracket after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = "("
        result += "("
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    @IBAction func rightBracket(_ sender: UIButton) {
        if(!IsNumber(temp)){
            errorLabel("You can write ')' symbol only after number", labelSecond)
            return
        } else if (IsBracket(temp)) {
            errorLabel("You can not write bracket after bracket", labelSecond)
            return
        } else if (temp == "^"){
            errorLabel("You can not write brackets after pow", labelSecond)
            return
        } else if (temp == "."){
            errorLabel("You can not write a bracket after dot", labelSecond)
            return
        }
        tempNumber = ""
        temp = ")"
        result += ")"
        labelMain.text = result
        IsResult = false
        clearLabel(labelSecond)
    }
    
    
    @IBAction func actionEqual(_ sender: UIButton) {
        if(IsOperator(temp)){
            errorLabel("You can not calculate after an operator", labelSecond)
            return
        } else if (temp == ".") {
            errorLabel("You can not calculate after dot", labelSecond)
            return
        } else if (temp == "(") {
            errorLabel("You can not calculate afte '(' symbol", labelSecond)
            return
        } else if (result.last == "." || result.last == "(" || IsOperator(String(result.last!))){
            errorLabel("You can not calculate in this situation", labelSecond)
            return
        }
        result = Calculate(result)
        if(result == "inf"){
            labelMain.text = "Error: you can not divide by zero"
            result = ""
            temp = result
            IsResult = true
            return
        } else {
            labelMain.text = result
            temp = result
            IsResult = true
            return
        }
        
    }
    
    
    

    
    
    
    
}

