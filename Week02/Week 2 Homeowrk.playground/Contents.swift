import Foundation

let path = Bundle.main.path(forResource: "Bunny", ofType: "txt")
let str = try String(contentsOfFile: path ?? <#default value#>, encoding: .utf8)

// same as a function
func load(_ file :String) -> String {
  let path = Bundle.main.path(forResource: file, ofType: nil)
  let str = try? String(contentsOfFile: path!, encoding: .utf8)
  return str!
}

print(load("Bunny.txt"))

// Source:
// http://artscene.textfiles.com/asciiart/
// https://asciiart.website/index.php?art=animals/aardvarks
