import UIKit

//Structs let us create our own complex data types with our own variable and functions
struct Album {
    let title : String
    let artist : String
    let year: Int
    func printSummary(){
        print("\(title) (\(year)) by \(artist)")
    }
}
//now this can be called again and again:
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)
print(red.title)
print(wings.artist)
red.printSummary()
wings.printSummary()

//value inside of stucts that we want to change
struct Employee {
    //properties of struct
    //2 types: 1: Stored - place a value into sctruct directly, 2: Computed - recalculated
    let name: String
    var vacationRemaining: Int
    //methods of structs
    mutating func takeVacation(days: Int) { //mutating is mandatory to edit a variable
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining for \(name): \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}
//instance of a struct
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14) //this is the initializer for the struct.
archer.takeVacation(days: 5)
//print(archer.vacationRemaining)

struct employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    var vacationRemaining: Int { //computed property
        //to get vacationRemaining
        get{
            vacationAllocated - vacationTaken
        }
        //to set vacationRemaining
        set{
            vacationAllocated = vacationTaken + newValue//automatically given by swift for vacation Remaining
        }
    }
}
var Archer = employee(name: "Sterling Archer", vacationAllocated: 14)
Archer.vacationTaken += 4
Archer.vacationRemaining = 5
print(Archer.vacationAllocated)
//Archer.vacationTaken += 4
//print(Archer.vacationRemaining)

//property observers which runs everytime a property value chnages.
//two forms. 1. didSet observer to run when the property just changed, 2. willSet observer to run before the property changed

//struct Game{
//  var score = 0
//}
//var game = Game()

//will haver to print the score everytime there is a change in score.
//game.score += 10
//print ("Score is now \(game.score)")
//game.score -= 3
//print("Score is now \(game.score)")
//game.score += 1

//therefore another way to do this: 
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}
var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")


//initializer are special functions inside structs designed to create initial values for properties inside the structs
//memberwise initilaizer:
struct Player {
    let name: String
    let number: Int
}
let player = Player(name: "Megan R", number: 15)

//the above code can also be written as:
struct Players {
    let name: String
    let number: Int
    //this can be cutomised
    init(name: String, number: Int) {
        self.name = name //self is used to assign the name parameter to the self name property
        self.number = number
    }
}

//other ways for initializer
struct Play {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}
let play = Play(name: "Megan R")
print(player.number)

