//
//  ContentView.swift
//  iExpense
//
//  Created by Арсений Токарев on 15.09.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
	var id = UUID()
	let name: String
	let type: String
	let amount: Int
}

class Expenses: ObservableObject {
	@Published var items = [ExpenseItem]() {
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(items) {
				UserDefaults.standard.set(encoded, forKey: "Items")
			}
		}
	}
	
	init() {
		if let items = UserDefaults.standard.data(forKey: "Items") {
			let decoder = JSONDecoder()
			if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
				self.items = decoded
				return
			}
		}
		
		self.items = []
	}
}

struct ContentView: View {
	@ObservedObject var expenses = Expenses()
	@State public var showAddView = false
    var body: some View {
		NavigationView {
			List {
				ForEach(expenses.items) { item in
					HStack {
						VStack(alignment: .leading) {
							Text(item.name)
								.font(.headline)
							Text(item.type)
								.font(.caption)
						}
						
						Spacer()
						
						Text("$\(item.amount)")
							.expenseStyling(with: item.amount)
					}
				}
				.onDelete(perform: removeItems)
			}
			.navigationBarTitle("iExpense")
			.navigationBarItems(leading:EditButton(), trailing:
				Button(action: {
					self.showAddView = true
				}) {
					Image(systemName: "plus")
				}
			)
		}
		.sheet(isPresented: $showAddView) {
			AddView(expenses: self.expenses)
		}
		
    }
	
	func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ModifyExpenseField: ViewModifier {
	let amount: Int
	var color: Color {
		switch amount {
		case 0 ..< 10 :
			return .green
		case 10 ..< 100 :
			return .orange
		default :
			return .red
		}
	}
	func body(content: Content) -> some View {
		content
			.font(.callout)
			.padding(10)
			.background(color)
			.cornerRadius(10)
		
	}
}

extension View {
	func expenseStyling(with amount: Int) -> some View {
		self.modifier(ModifyExpenseField(amount: amount))
	}
}
