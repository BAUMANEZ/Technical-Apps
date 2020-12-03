//
//  AddView.swift
//  iExpense
//
//  Created by Арсений Токарев on 16.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct AddView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = ""
	
	static let types = ["Personal", "Business"]
	
    var body: some View {
		NavigationView {
			ZStack {
				Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)
				VStack {
					VStack {
						TextField("Name", text: $name)
							.textFieldStyle(RoundedBorderTextFieldStyle())
						
						Picker("Type of expense", selection: $type) {
							ForEach(Self.types, id: \.self) {
								Text($0)
							}
						}
						.pickerStyle(SegmentedPickerStyle())
						
						TextField("Amount", text: $amount)
							.keyboardType(.numberPad)
							.textFieldStyle(RoundedBorderTextFieldStyle())
					}
					.padding()
					.background(Color(.systemTeal))
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.padding()
					
					Button("Add") {
						guard let numberAmount = Int(self.amount) else { return }
						self.expenses.items.append(ExpenseItem(name: self.name, type: self.type, amount: numberAmount))
						self.presentationMode.wrappedValue.dismiss()
					}
					.padding()
					.frame(width: UIScreen.main.bounds.width - 2 * 75)
					.background(Color.white)
					.clipShape(Capsule())
					.overlay(
						Capsule()
							.stroke(Color(.systemTeal), lineWidth: 2)
					)
					.padding()
						.navigationBarTitle("Expense details", displayMode: .inline)
				}
			}
		}
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
