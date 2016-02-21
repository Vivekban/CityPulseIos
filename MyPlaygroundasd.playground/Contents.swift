//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



var formatter = NSDateFormatter()


func run(){
    formatter.dateFormat = "YYYY-MM-DD"
    let ds = formatter.stringFromDate(NSDate())
    formatter.dateFromString(ds)
}


run()