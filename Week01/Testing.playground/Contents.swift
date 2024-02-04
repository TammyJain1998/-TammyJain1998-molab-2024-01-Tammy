import UIKit

//arrays store many values in one place. Must always be specialized
//dictionary also store many values, but we use keys to give out values

//enums
enum UIStyle {
  case light, dark, system
}
//assigning ui style to the style variable
var style = UIStyle.light
//now can remove enum name for future
style = .dark

//annotation of enum will be
var STYLE : UIStyle = UIStyle.light

//annotations of arrays
var players: [String] = ["Roy", "TJ"]
//annotations of sets
var books: Set<String> = Set([
    "The Bluest Eye",
    "Foundation",
    "Girl, Woman, Other"
])
//annotations of dictionaries
var user: [String: String] = ["id": "@twostraws"]

//if you want an empty array
var teams: [String] = [String]() 
//or you can also say
var city: [String] = []
//or
var clues = [String]() //basically making an empty array


//can also work annotation with constant, just cannort write to it more than once
let username : String
username = "@Tamanna"
//print(username)



let names = ["Tamanna", "Aru", "Aashni", "Chams", "Aru", "Chams"]
let count = names.count
print(count)

let unique = Set(names)
let counts = unique.count
print(counts)
