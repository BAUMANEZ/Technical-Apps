 //
//  ContentView.swift
//  Volume Converter
//
//  Created by Арсений Токарев on 03.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI
 
 enum VolumeUnits: String {
    case milliliters
    case liters
    case cups
    case pints
    case gallons
 }

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var numberToConvert = ""
    
    let volumeUnits: [VolumeUnits] = [.milliliters, .liters, .cups, .pints, .gallons]
    
    
    func convertValueToMilliliters(value: String, unit: VolumeUnits) -> Double {
        guard let unwrappedValue = Double(value) else { return 0}
        switch unit {
            case .cups:
                return unwrappedValue * 237
            case .gallons:
                return unwrappedValue * 3785.4
            case .liters:
                return unwrappedValue * 1000
            case .milliliters:
                return unwrappedValue
            case .pints:
                return unwrappedValue * 568.26
        }
    }
    
    var convertedValue: Double {
        let inputValue = convertValueToMilliliters(value: numberToConvert, unit: volumeUnits[inputUnit])
        
        switch volumeUnits[outputUnit] {
            case .cups:
                return inputValue / 237
            case .gallons:
                return inputValue / 3785.4
            case .liters:
                return inputValue / 1000
            case .milliliters:
                return inputValue
            case .pints:
                return inputValue / 568.26
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Input unit")
                    .fontWeight(.bold)) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<volumeUnits.count) {
                            Text("\(self.volumeUnits[$0].rawValue)")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output unit") .fontWeight(.bold)) {
                    Picker("Output Unit", selection: $outputUnit) {
                            ForEach(0..<volumeUnits.count) {
                                Text("\(self.volumeUnits[$0].rawValue)")
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Enter the value to convert", text: $numberToConvert)
                }
                Section (header: Text("Converted value")
                    .fontWeight(.heavy)) {
                    Text("\(convertedValue, specifier: "%g")")
                }
                
            }
            .navigationBarTitle("Volume converter", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
