//
//  ContentView.swift
//  WeSplit
//
//  Created by Арсений Токарев on 20.07.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 1
    let tipPercantages = [5, 8, 10, 15, 18, 20, 25, 0]
    
    var totalCheque: Double {
        guard let totalPrice = Double(checkAmount) else {
            return 0
        }
        let tipAmount = totalPrice / 100 * Double(tipPercantages[tipPercentage])
        return totalPrice + tipAmount
    }
    var totalPerPerson: Double {
        guard Double(numberOfPeople) != nil else {
            return 0
        }
        return totalCheque / Double(numberOfPeople)!
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercantages.count) {
                            Text("\(self.tipPercantages[$0])%")
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Total cheque amount plus tips")) {
                    Text("$\(totalCheque, specifier: "%.2f")")
                }
                Section (header: Text("Amount per person")
                    .fontWeight(.heavy)) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .bold()
                        .padding(4)
                        .background(tipPercentage == tipPercantages.count - 1 ? Color(red: 2, green: 0.25, blue: 0) : nil)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        
                }
            }
            .navigationBarTitle("WeSplit", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
