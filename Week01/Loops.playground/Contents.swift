import UIKit
 
//FOR LOOP
//using loops, you can do repetitive work
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
//don't need to create a new variavle, it automatically creates os as a variable
for os in platforms {
    print("Swift works great on \(os).")
} //os gets a new value in every loop iteration

for i in 1...12{
    print("5 X \(i) is \(5 * i)")
}
//loops inside loops
for i in 1...12 { //in here, you are counting from 1 to 12, to count from 1 to less than 12, you write 1..<12
    print("The \(i) times table:")
// for everytime we go around 1 of i, you go around 1 through 12 of j
    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }
    print() // to add an empty line in between prints
}

//if you dont want a loop variable like i or j, you use undescore as variable:
var lyric = "Haters gonna"
for _ in 1...5 {
    lyric += " hate"
}
print(lyric)

//mixing loops and ocndistionals
var numbers = [1, 2, 3, 4, 5, 6]
for number in numbers {
    if number % 2 == 0 {
        print(number)
    }
}

//WHILE LOOP
//use while loops until any arbitrary condition becomes false, which allows them until we tell them to stop.
//craete an integer conter starting at 10 that decreases as long as the conditional is true
var countdown = 10
while countdown > 0 {
    print("\(countdown)…")
    countdown -= 1
}
print("Blast off!")

//you can take a random number from an array of numbera using the random int or random doble function
let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

//use this whith a while loop supposedly with a dice that kkeps on rolling and only stops when a 20 is rolled
var roll = 0
while roll != 20{
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}
print("Finallya 20")

var cats: Int = 0
while cats < 10 {
    cats += 1
    print("I'm getting another cat.")
    if cats == 4 {
        print("Enough cats!")
        cats = 10
    }
}

//modulo in loops
var number: Int = 10
while number > 0 {
    number -= 2
    if number % 2 == 0 {
        print("\(number) is an even number.")
    }
}

//how to skip 1 or more items in a loop either by using CONTINUE to skip or BREAK to exit a loop
let fileName = [".jpg", ".text", ".html"]
for name in fileName {
    if name.hasSuffix(".jpg") == false{
        continue
    }
    print("Found picture \(fileName)")
} //this will not take the filname that does not have.jpg

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...1000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)

for n in 1...100{
    if n.isMultiple(of: 3) && n.isMultiple(of: 5){
        print("FizzBuzz")
    } else if n.isMultiple(of: 3){
        print("Fizz")
    } else if n.isMultiple(of: 5){
        print("Buzz")
    } else {
        print("\(n)")
    }
}
