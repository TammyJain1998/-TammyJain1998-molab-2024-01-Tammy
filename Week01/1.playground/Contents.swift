import Foundation

// Function to generate a line of the staircase
func generateStaircaseLine(_ stepCount: Int) -> String {
    var staircaseLine = ""
    
    for step in 1...stepCount {
        staircaseLine += "°|"
    }
    return staircaseLine
}
// Function to generate a staircase with a specified number of steps
func generateStaircase(_ totalSteps: Int) {
    for currentSteps in 1...totalSteps {
        let line = generateStaircaseLine(currentSteps)
        print(line)
    }
    for currentSteps in stride(from: totalSteps - 1, through: 1, by: -1) {
        let line = generateStaircaseLine(currentSteps)
        print(line)
    }
}
// Specify the total number of steps in the staircase
let totalSteps = 50
// Generate and print the staircase
generateStaircase(totalSteps)
//file
