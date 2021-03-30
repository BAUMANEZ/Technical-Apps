//
//  ContentView.swift
//  BetterRest
//
//  Created by Арсений Токарев on 10.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = morningTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
	
	static var morningTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
	
	
    var recommendedBedtime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 3600
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            return "Sorry, there was some sort of a problem"
        }
    }
    

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("When do you want to wake up?")
                            .font(.headline)

                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Desired amount of sleep")
                            .font(.headline)

                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Daily coffee intake")
                            .font(.headline)

                Picker("Amount of coffee", selection: $coffeeAmount) {
                            ForEach(1 ..< 10) {
                                if $0 == 1 {
                                    Text("1 cup")
                                } else {
                                    Text("\($0) cups")
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Recommended bedtime")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                ){
                    Text(recommendedBedtime)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// func!!!

//  @State private var alertTitle = ""
//  @State private var showingAlert = false


//            .navigationBarItems(trailing:
//                Button(action: calculateBedtime) {
//                    Text("Calculate")
//                }
//
//            )
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }



//let model = SleepCalculator()
//
//let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//let hour = (components.hour ?? 0) * 3600
//let minute = (components.minute ?? 0) * 60
//do {
//    let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
//
//    let sleepTime = wakeUp - prediction.actualSleep
//    let formatter = DateFormatter()
//    formatter.timeStyle = .short
//
//    alertMessage = formatter.string(from: sleepTime)
//    alertTitle = "Your ideal bedtime is…"
//
//} catch {
//    alertTitle = "Error"
//    alertMessage = "Sorry, there was a problem calculating your bedtime."
//}



//MARK: Another option of changing coffee values

//                    Stepper(value: $coffeeAmount, in: 1...20) {
   //                        if coffeeAmount == 1 {
   //                            Text("1 cup")
   //                        } else {
   //                            Text("\(coffeeAmount) cups")
   //                        }
   //                    }
          
