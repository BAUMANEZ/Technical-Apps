import UIKit



func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1,2,6,124)


//MARK: Working with SETS

//Declaration
var letters = Set<Character>(["a", "b", "c"])
letters.count
//or
let lettersAlternative: Set = [2, 3, 6, 1, 6, 8, 5, 4, 3, 2, 1] //repeating values are always excluded from the set
lettersAlternative.count // 7 instead of 12 (declared above)
//or
let lettersOneMoreAlternative = Set([true, false, true, true, false]) //actually it has only two instances, because sets keep unique values (repeating items are excluded)
//empty set
let emptySet = Set<String>()
//Some methods
let deletedValue = letters.popFirst() //deletes the first elemnt from the SET and returns it
letters

if let removedElement = letters.remove("c") {
    print(removedElement)
}
else {
    print("There is no such element in the SET")
}

letters
letters.insert("a")
if letters.contains("a") {
    print("\("ºaº") is presented in the SET")
}
else {
    print("Cannot find this element")
}

//Erasing the SET
letters = []
//or
letters.removeAll()

//iterating
for num in lettersAlternative {
    //print(num)
    num
}

let tuple: (Int, Double, Bool) = (100, 10.21, true)


//MARK: Dictionaries
//Declaration
var airports: [String:String] = ["UUEE":"Sheremetevo"]
//adding new element
airports.updateValue("Domodedovo", forKey: "UUDD") // there was no such element in the dictionary. That is why it was added automatically
//or
airports["Some new key"] = "Some New Value"

//empty dictionary
let emptyDictionary: [Int:Int] = [:] //or = Dictionary<Int,Int>()

//iterating over elements
for (keys,values) in airports {
    keys
    values
}
for keys in airports.keys {keys}
for values in airports.values{values}

//putting dictionary in array
let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)



/*
 We need labeled loops or statements in order to break them once we get the needed result
 
outerLoop: for option1 in options {
    for option2 in options {
        for option3 in options {
            print("In loop")
            let attempt = [option1, option2, option3]

            if attempt == secretCombination {
                print("The combination is \(attempt)!")
                break outerLoop
            }
        }
    }
}
*/


//MARK: CLOSURES
let closure = {
    let str = "Some string"
    print(str)
}

let intToStr = { (a: Int) -> String in
    return "\(a)"
}


let increaseSomeValue = {a in   //return and variable types can be omitted
    a + 1
}
increaseSomeValue(1)

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
//default value
favoriteIceCream["Charlotte", default:"Unknown"] //returns unknown rather than nil

var array = ["Maria", "Arseny", "Artemy"]
array.sort(by: {$0 < $1}) //even argument names can be omitted and be anonymous
//WOW you can even write it like that
array.sort(by: >)

//Using closures as parameters when they accept parameters
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
travel { (place: String) in
    print("I'm going to \(place) in my car")
}
//or
travel {
    print("I'm going to \($0) in my car")
}


//MARK: ENUMERATIONS
//declaration
enum Meals {
    case breakfast
    case lunch
    case dinner
    case snack
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune //it is also possible to separate cases by comma
}
//possible assignments
let planetI = Planet.mercury
let planetII: Planet = .earth

let myFood: Meals = .lunch
switch myFood {
case .lunch:
    "Wow, you have a lunch!"
case .breakfast:
    "You've woken up so early!"
case .snack:
    "Can't you wait till lunch?!"
case .dinner:
    "Bon appetit!"
}


//Assosiated values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productCocaCola = Barcode.qrCode("iLikeDrinkingSweetyCoraRora")
switch productCocaCola {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode) where productCode != "":
    print("QR code: \(productCode).")
default:
    break
}

//Raw values
enum Date: String {
    case July4th = "The Independence"
    case December25th = "Christmas"
    case February14th // automatically assigns "February14th"
}
Date.February14th.rawValue

let checkIt = Date.February14th.rawValue //VERY IMPORTANT!! to write .rawValue otherwise the checkIt will have a Date type (enum)

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}


//MARK: Classes and Structs

//Property Observers
struct Plane {
    var model: String
    var numberOfFlights: Int {
        didSet {
            print("Now this plane has made \(numberOfFlights) flights")
        }
        
        willSet {
            print("Previously there were \(numberOfFlights) flights")
        }
    }
}
var boeing = Plane(model: "737-800", numberOfFlights: Int.random(in: 0..<100))
boeing.numberOfFlights += 1

protocol Identifiable {
    var id: String {get}
}

struct Product: Identifiable {
    var id: String
    
}

var cocaCola = Product(id: "iLoveIt")
cocaCola.id += "VeryMuch"


