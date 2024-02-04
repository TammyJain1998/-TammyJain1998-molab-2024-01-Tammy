import UIKit

var greeting = "Hello, playground"
print(greeting)

//testing out conditionals of if
let age = 19
if age > 18 {
    print("Happy Birthday")
}
let speed = 88
let percentage = 85

if speed >= 88 {
    print("Where we're going, we dont need roads")
}


let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"
if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
}
if ourName > friendName {
    print("It's \(friendName) vs \(ourName)")
}


//if adding a number to an array makes it contain more than 3 items, remove the oldest one
var numbers = [1,2,3]
numbers.append(4)
if numbers.count > 3 {
    numbers.remove(at: 0)
}
print(numbers)

//if the user was asked to enetr a name and typed nothing, then give them a default name of anonymous
var name = "Tamanna Jain"
//"" represents an empty string
//can also be done by giving count value to 0
if name == "" {
    name = "Anonymous"
}
//can also be done by using if name.isempty. it will send back true if the string is empty
print("Welcome! \(name)")

//enums into conditions
enum tranOptions {
    case airplane, helicopter, car, cycle
}
let transport = tranOptions.airplane
if transport == .airplane || transport == .helicopter {
    print("Lets Fly")
} else if transport == .cycle {
    print("Ride")
} else {
    print("Drive")
}


//how to use SWITCH CONDITION
enum Weather {
    case sun, rain, wind, snow, unknown
}
let forecast = Weather.sun
if forecast == .sun {
    print("It should be a nice day.")
} else if forecast == .rain {
    print("Pack an umbrella.")
} else if forecast == .wind {
    print("Wear something warm")
} else if forecast == .snow {
    print("School is cancelled.")
} else {
    print("Our forecast generator is broken!")
}
//this can also be written to make it simpler, so that there is no repetition, so that you dont check samencondition twice
switch forecast{
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}
//with switch, have to make sure that every case is covered
//with strings:

let place = "Met"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
    //default must go in th end, orherwise others won't be checked
default:
    print("Who are you?")
}
 
//use function fallthrough in between switched ot add previos condition on top of other:
let day = 5
print("My true love gave to me…")
switch day {
case 5:
    print("5 golden rings")
    fallthrough //through this, when day 5, it will rpint day 5 and then fall through to day 4 and print that as well instead of crossing that out
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

//TRNARY Conditionals
//2+5, + sign is a binary operator. Ternary operator has 3 pieces of data
//through Ternary, you check a condition and then send back either one value, or another value dpeending on results

let Age = 18
let canVote = age >= 18 ? "yes" : "no"
//first = condition of is age >= 18, second = send back yes bwcause it is true, third == sned back no if it is false

let hour = 23
print(hour < 12 ? "It is before noon" : "After Noon" )

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount)

//with enums
enum Theme {
    case light, dark
}
let theme = Theme.dark
let background = (theme == .dark) ? "black" : "white"
print(background)
