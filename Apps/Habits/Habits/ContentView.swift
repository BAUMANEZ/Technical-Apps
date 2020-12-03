//
//  ContentView.swift
//  Habits
//
//  Created by Арсений Токарев on 27.09.2020.
//

import SwiftUI

struct ColorTheme: Codable {
	 private var backgroundColorHex: String
	 private var foregroundColorHex: String
	
	var backgroundColor: Color {
		get {
			return Color(hex: backgroundColorHex)
		}
		
		set {
			self.backgroundColorHex = newValue.toHex() ?? "#000000" //black for default
		}
	}
	
	var foregroundColor: Color {
		get {
			return Color(hex: foregroundColorHex)
		}
		
		set {
			self.foregroundColorHex = newValue.toHex() ?? "#ffffff" //white for default
		}
	}
	
	init(backgroundColorHex: String, foregroundColorHex: String) {
		self.backgroundColorHex = backgroundColorHex
		self.foregroundColorHex = foregroundColorHex
	}
}

struct Activity: Codable, Identifiable, Equatable {
	static func == (lhs: Activity, rhs: Activity) -> Bool {
		return lhs.title == rhs.title && lhs.id == rhs.id
	}
	
	
	
	//Nested Struct associated only with an Activity struct
	struct Subgoal: Codable, Identifiable {
		var id = UUID()
		var details: String
		var completionCount = 0
		var checked: Bool = false
	}
	
	
	
	
	//Details
	var id = UUID()
	var title: String
	var description: String?
	var completionCount = 0
	var completed: Bool = false
	
	//Design
	var associatedImage: String
	var colorTheme: ColorTheme
	
	//Additional features
	var subgoals: [Subgoal]
	
	mutating func addSubgoal(details: String, completionCount: Int) {
		self.subgoals.append(Subgoal(details: details, completionCount: completionCount))
	}
	
	
}


class Hobby: ObservableObject {
	@Published var activities: [Activity] {
		didSet {
			let encoder = JSONEncoder()
			if let encodedData = try? encoder.encode(activities) {
				UserDefaults.standard.set(encodedData, forKey: "Activities2")
			}
		}
	}
	
	init() {
		
		if let data = UserDefaults.standard.data(forKey: "Activities2") {
			let decoder = JSONDecoder()

			if let decodedData = try? decoder.decode([Activity].self, from: data) {
				self.activities = decodedData
				return
			}
		}
		//If deocding or reading data from the system storage fails we return an empty array of activities
		self.activities = [Activity(title: "Test", associatedImage: "sport3", colorTheme: ColorTheme(backgroundColorHex: " #ffff66", foregroundColorHex: "#000000"), subgoals: [])]
	}
	
	func deleteActivity(_ activity: Activity) {
		if let index = self.activities.firstIndex(of: activity) {
			self.activities.remove(at: index)
		}
	}
	
	
	func giveIndex(of activity: Activity) -> Int {
		if let index = self.activities.firstIndex(of: activity) {
			return index
		}
		fatalError("Could not find the activity member")
		
	}
	
	
}


struct ContentView: View {
	@ObservedObject var hobby = Hobby()
	@State private var isEditing = false
	var body: some View {
		NavigationView {
			ZStack {
				Color(hex: "#99D5C9").edgesIgnoringSafeArea(.all)
				VStack {
					ScrollView {
						HStack {
							Spacer()
							Button(isEditing ? "Done" : "Edit") {
								withAnimation {
									self.isEditing.toggle()
								}
							}
							.foregroundColor(Color(hex: "#FEF9FF"))
							.font(.system(size: 15, weight: .semibold))
							.frame(width: 80, height: 45)
							.background(Color(hex: "#9B5DE5"))
							.cornerRadius(10)
							.padding(.horizontal)
						}
						VStack {
							HStack {
								Text("HABBY")
									.font(.largeTitle)
									.fontWeight(.bold)
									.foregroundColor(Color(hex: "#2D0320"))
									.padding([.horizontal, .bottom])
								Spacer()
							}
							ForEach(hobby.activities) { activity in
								HStack {
									NavigationLink(destination: HabitDetailedView(hobby: hobby, backgroundColor: activity.colorTheme.backgroundColor, activityIndex: hobby.giveIndex(of:activity))) {

										HabitBriefView(title: activity.title, imageName: activity.associatedImage, colorTheme: activity.colorTheme)
											.frame(height: 125)
											.padding([.vertical, .horizontal], 5)
											.animation(
												Animation
													.easeOut(duration: 0.3)

											)

									}
									if isEditing {
										Image(systemName: "trash.circle")
											.resizable()
											.frame(width: 30, height: 30)
											.foregroundColor(Color(.systemRed))
											.padding(.trailing)
											.animation(
												Animation
													.easeOut(duration: 0.3)
											)
											.transition(.move(edge: Edge.trailing))
											
											.onTapGesture(perform: {
												withAnimation {
													self.hobby.deleteActivity(activity)
												}
											})
									}
								}
									
							}
						}
					}
					HStack {
						Spacer()
						NavigationLink(destination: AddView(hobby: hobby)) {
							Image("plus.button")
								.resizable()
								.scaledToFill()
								.frame(width: 60, height: 60)
								.padding([.trailing, .bottom], 10)
						}
					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Making rounded tile that rises above the content of the screen.
//We can put buttons on this tile (looks best with NavigationButtonDesign described below)
struct NavigationBarDesign: ViewModifier {
	func body(content: Content) -> some View {
		content
			.frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height * 0.15)
			.background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.6)]), startPoint: .bottom, endPoint: .center))
			.background(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0)]), startPoint: .center, endPoint: .top))
	}
}

extension View {
	func transparentNavigationBar() -> some View {
		self.modifier(NavigationBarDesign())
	}
}

//Circle buttons with light shadows
struct NavigationButtonDesign: ViewModifier {
	func body(content: Content) -> some View {
		content
		   .foregroundColor(Color.black)
		   .padding()
		   .background(Color.white)
		   .clipShape(Circle())
		   .shadow(color: Color.black.opacity(0.1), radius: 10, x: -2, y: 5)
	}
}

extension View {
	func roundedShadowedButton() -> some View {
		self.modifier(NavigationButtonDesign())
	}
}




extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (1, 1, 1, 0)
		}

		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue:  Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
	
	func toHex() -> String? {
		let uiColor = UIColor(self)
		return uiColor.toHex()
	}
}

extension UIColor {
	func toHex(alpha: Bool = false) -> String? {
			guard let components = cgColor.components, components.count >= 3 else {
				return nil
			}

			let r = Float(components[0])
			let g = Float(components[1])
			let b = Float(components[2])
			var a = Float(1.0)

			if components.count >= 4 {
				a = Float(components[3])
			}

			if alpha {
				return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
			} else {
				return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
			}
	}
}
