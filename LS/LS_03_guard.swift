
/*
 
 LS_03_guard.swift
 
 Swift Playgrounds 4.1, Swift 5.8
 
 Made on 8/22/2023
 
 Reference:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 

The guard keyword lets you define a test that needs to pass; alternatively, if it 
doesn’t pass, a different block of code is run. 

*/

func doAThing(){
    guard 2+2 == 4 else {
        print("The universe makes no sense")
        return
    }
    print("We can continue with our daily lives")
}

doAThing()

// We can continue with our daily lives



func doSomeStuff(importantVariable: Int?)
{
    guard let importantVariable = importantVariable else
    {
        // we need the variable to exist to continue
        return
    }
    print("doing important work with number \(importantVariable)")
}
doSomeStuff(importantVariable: 3) // works as expected
doSomeStuff(importantVariable: nil) // exits function on the guard statement


