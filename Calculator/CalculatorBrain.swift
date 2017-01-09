//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Zac on 9/15/16.
//  Copyright © 2016 Zac.com. All rights reserved.
//

import Foundation
/////////////////////////////
// Optional is an enum, here is it's source code looks like
//enum Optional<T> {
//    case None
//    case Some(T)
//}

// Global function outside the scope
//func multiply(op1: Double, op2: Double) -> Double {
//    return op1 * op2
//}

// When a class is created, a free initialzer is provided
class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double)
    {
        accumulator = operand
    }
    
    // Dictonary = Map in Java
    private var operations: Dictionary<String, Operation> = [
        
        "π": Operation.Constant(M_PI), // M_PI,
        
        "e": Operation.Constant(M_E), // M_E
        
        "": Operation.UnaryOperation({ -$0}), // x -1
        
        "√": Operation.UnaryOperation(sqrt), // sqrt
        
        "cos": Operation.UnaryOperation(cos), // cos
        
//        "x": Operation.BinaryOperation({(op1, op2) in return op1 * op2}),
        
        "x": Operation.BinaryOperation({$0 * $1}), // closure, 1 line function
        
        "+": Operation.BinaryOperation({$0 + $1}),
        
        "-": Operation.BinaryOperation({$0 - $1}),
        
        "/": Operation.BinaryOperation({$0 / $1}),
        
        "=": Operation.Equals
    ]
    
    // enum is a discrete set of values, it can have func inside
    // enum can't have var
    // enum is passed by value
    // enum can't have inheritance
    private enum Operation
    {   // PI, E
        case Constant(Double)
        // sqrt, cos
        case UnaryOperation((Double) -> Double)
        // add, multiply, substitude, divide
        case BinaryOperation((Double, Double) -> Double)
        // =
        case Equals
    }
    
    // Perform operation by passing enum Operation
    func performOperation(symbol: String)
    {
        if let operation = operations[symbol]
        {   // Only 4 operations here, no need default
            switch operation
            { // Operation.Constant
            case .Constant(let value):
                
                accumulator = value
            // Operation.UnaryOperation
            case .UnaryOperation(let function):
                
                accumulator = function(accumulator)
                
            case .BinaryOperation(let function):
                // auto "=" whenever operand finished, when do +-x/ multiple times, it produce the answer automatically
                executePendingBinaryFunction()
                
                pending = PendingBinaryOpeationInfo(binaryFunction: function, firstOperand: accumulator)
                
            case .Equals:
                
                executePendingBinaryFunction()
            }
        }
    }
    
    // Equals function
    private func executePendingBinaryFunction()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            
            pending = nil
        }
    }
    
    // Optional PendingBinaryOperation "?", default is nil
    private var pending: PendingBinaryOpeationInfo?
    
    // struct like enum, both passed by value (copy), no inheritance
    // array, Double, Int, are all passed by
    //
    // class passed by reference (pointer), in heap, shared same data
    private struct PendingBinaryOpeationInfo
    {   // A function takes 2 doubles return 1 double
        var binaryFunction: (Double, Double) -> Double
        
        var firstOperand: Double
    }
    
    // Read-only property
    var result: Double
        {
        get
        {
            return accumulator
        }
    }
    
}
