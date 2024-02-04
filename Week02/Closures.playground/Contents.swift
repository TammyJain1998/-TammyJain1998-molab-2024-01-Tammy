import UIKit

//we can assign functions to variables, pass functions into functions and return functions from functions
func greetUser(){
print("Hi")
}
greetUser()
//() -> Void means this function returns no value and can be:
var greetCopy: () -> Void = greetUser //when copying afunction, we dont use()
greetCopy()

//to avoid creating a separate function and just assign the functionality to the constant:
let sayHello = {
    "Hi There"
}
sayHello() //this is a closure. a chunch of code that we can pass around and call whenever we want.
//closere to set parameters
let sayHi = { (name: String) -> String in
    "Hi \(name)!"
} //with a regular functions the parameters come outside of {}, but in closure, it comes inside{} and so "in" is a markers and separater s the parameters from the body
sayHi("Taylor")

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)
//func captainFirstSorted(name1: String, name2: String) -> Bool {
//    if name1 == "Suzanne" {
//        //if first name is sussane, name1 should come before name2
//        return true
//    } else if name2 == "Suzanne" {
//        //if name2 is sussane, then name2 should come before name1
//        return false
//    }
//    return name1 < name2
//}
//let captainFirstTeam = team.sorted(by : captainFirstSorted) //pass a funtion into another
//print(captainFirstTeam)

//all that can also be written as
//let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
//    if name1 == "Suzanne" {
//        //if first name is sussane, name1 should come before name2
//        return true
//    } else if name2 == "Suzanne" {
//        //if name2 is sussane, then name2 should come before name1
//        return false
//    }
//    return name1 < name2
//})
//print(captainFirstTeam)

//to make the syntax simpler, this can be written as: and in this the dictionries go abd the by:() also go
//let captainFirstTeam = team.sorted { name1, name2 in
//    if name1 == "Suzanne" {
//        return true
//    } else if name2 == "Suzanne" {
//        return false
//    }
//
//    return name1 < name2
//}

//another simpler syntax for this would be to add in built swift naming dictionary pf $0,$1 ...: in that even the name1, name2 and in will go
let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}
print(captainFirstTeam)

//to reverse sort the array
let reverseTeam = team.sorted {$0 > $1}
print(reverseTeam)

let tonly = team.filter {$0.hasPrefix("T")}
print(tonly)

//map function that lets us transform every item in an array using some code of our choosing
let uppercaseTeam = team.map {$0.uppercased()}
print(uppercaseTeam)

//write a function that accept funtions as parameters
//example: wrote a unctions thatgenerates and array of integers by calling another function repeatedly
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    //a function called makeArray with 2 parameters: size integer and generator function. Generator function is the function it accepts. It says, i will accept no parameters shown by (), but i will return integer everytime i am called
    var numbers = [Int]() //male a new empty integer array
    for _ in 0..<size {
        let newNumber = generator() //then call the generator function
        numbers.append(newNumber) //then add it into the array
    }
    return numbers
}

let rolls = makeArray(size : 50) {
    Int.random(in: 1...20)
}
print(rolls)

//all this is essentially the same as:
func generateNumber() -> Int {
    Int.random(in: 1...20)
}
let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

//write a function that accepts 3 different function parameter each of which return nothing
func doImpWork( first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first word")
    first()
    print("About to start second word")
    second()
    print("About to start third word")
    third()
    print("done")
}
doImpWork {
    print("This is first word")
} second: {
    print("This is second word")
} third: {
    print("This is third word")
}
