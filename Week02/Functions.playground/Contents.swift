import UIKit
//FUNCTIONS
//Chunks of code that are given a name than can be used agin and again
let number = 149
//her isMultiple is a function
if number.isMultiple(of: 2){
    print("Even")
} else{
    print("Odd")
}
//here random(in: ) is a function
let roll = Int.random(in: 1...20)

func printTimesTables(number: Int){ //the number: int in () is called a parameter: argument/actual value
    for i in 1...12{
        print("\(i) * \(number) is \(i * number)")
    }
}
printTimesTables(number: 5)


//functions also pass a data back
let root = sqrt(169) //here sqrt is a function that exists in the swift database
print(root)

//to return a value from own function use -> before function openeing brace like if you want to return an int or a double and use return keyword
func rollDice() -> Int{
    return Int.random(in: 1...6)
}
let result = rollDice()
print(result)

//do two strings contain the same letters, regardless of their order? This function should accept two string parameters, and return true if their letters are the same
func matchStrings(string1 : String, string2 : String) -> Bool {
    return string1.sorted() == string2.sorted()
}

func pyth(a: Double, b: Double) -> Double{
    let input = (a * a) + (b * b)
    let root = sqrt(input)
    return root
}
let c = pyth(a: 3, b: 4)
print(c)

//to return multiple valuyes from a function, you could use an array
func GetUser() -> [String]{
    ["Taylor" , "Swift"]
}
let User = GetUser()
print("Name: \(User[0]) \(User[1])")

//tuples to return multiple values
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "TAMANNA", lastName: "JAIN")
}
let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")
//can also be written as:
//let(firstName, lastName) = getUser()
//print("Name: \(firstName) \(lastname)")

//can also be written as
func getUser3() -> (String, String) {
    ("TAMANNA", "JAIN")
}
let useR = getUser3()
print("Name: \(useR.0) \(useR.1)")

//naming and using parameters:
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
let string = "HELLO, WORLD"
let Result = isUppercase(string) //here in () we dint have to write string:string because we used _ at the top
print(Result)

func Table(_ number: Int){
    for i in 1...12{
        print("\(i)*\(number) is \(i * number)")
    }
}
Table(4)

var characters = ["Tamanna", "Shubhu", "Aashni", "Aru"]
print(characters.count)
characters.removeAll()
print(characters.count)
//sometimes, we might know that we want to add a lot more items as well so that swift knows that there is going to still be a capacity of that amount.
//removeAll(keepingCapacity : true)
//this way, even when you remove, the array can still carry 4 amount

//ERRORS in Functions
//Step1: Define all errors that might happen
//Step2: Write a function that works as normal but can throw 1 or more of those errors if a serious problem happens
//Step3: Try and run that function and handle the error that comes back
//Example: To check the strength of a password set by user.
enum PaswordError: Error{
    case short, obvious
}

func checkPasword(_ pasword: String) throws -> String{
    if pasword.count < 5{throw PaswordError.short}
    if pasword == "12345" {throw PaswordError.obvious}
    
    if pasword.count <= 8{
        return "OK"
    } else if pasword.count <= 10 {
        return "GOOD"
    } else {
        return "Excellent"
    }
}
//now we need to test it out so we do:
   let Pasword = "Tamanna.Jain"
do {
    let result = try checkPasword(Pasword)
    print("Pasword rating: \(result)")
} catch PaswordError.short {
    print("Please use a longer password.")
} catch PaswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
