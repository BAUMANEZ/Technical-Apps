//
//  AddView.swift
//  Habits
//
//  Created by Арсений Токарев on 27.09.2020.
//

import SwiftUI







enum Categories: String {
	case sport, music, computer, languages, reading, drawing
	case custom
	
	var backgroundColor: Color {
		switch self {
		case .sport :
			return Color(.systemPink)
		case .music :
			return Color(.systemGreen)
		case .computer :
			return Color(.systemYellow)
		case .languages :
			return Color(.systemOrange)
		case .reading :
			return Color(hex: "#CEE0F3")
		case .drawing :
			return Color(hex: "#F15BB5")
		default:
			return Color(.systemGray)
		}
	}
	
}



struct AddView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var hobby: Hobby
	
	@State private var title = ""
	@State private var description = ""
	@State private var subgoals: [Activity.Subgoal] = [Activity.Subgoal(details: "Count tracking")]
	@State private var backgroundColor = Color(.systemRed)
	@State private var foregroundColor = Color.black
	
	///If we use a pre-added categories we only need an index of this category, because names of these categories are stored in the array declared below
	@State private var categoryIndex = 0
	@State private var colorSchemeIndex = 0
	
	///Howeverm if we choose a custom category, we ought to create an identificator for it.
	@State private var category = ""
	var imageName: String {
		return categoryIndex == categories.count - 1 ? category : "\(categories[categoryIndex])\(Int.random(in: 1 ... 6))"
	}
	var disableApplyButton: Bool {
		
        //If we use pre-added categories, we have to check only a title view, because names of those categories are already known
		
		//If We use a custom category we should also check that the textfield where we input the name for this new categpry is not empty, either
			return self.title == "" || self.categoryIndex == self.categories.count - 1 && self.category == ""
	}
	
	let categories: [Categories] = [.sport, .music, .reading, .computer, .drawing, .languages, .custom]
    var body: some View {
		ZStack {
			Color(hex: "#00F5D4").edgesIgnoringSafeArea(.all)
			
			GeometryReader { geo in
					ScrollView(.vertical) {
						VStack(spacing: 30) {
							Spacer().frame(height: 30)
							VStack {
								HStack {
									Text("Title of a new activity")
										.font(.title3)
										.fontWeight(.medium)
										.foregroundColor(Color.white).opacity(0.9)
									Spacer()
								}
								TextField("What do you want to practice?", text: $title)
									.textFieldStyle(RoundedBorderTextFieldStyle())
							}
							.roundedTile()
							.padding(.horizontal, geo.size.width * 0.05 / 2)
							
							VStack {
								HStack {
									Text("Describe what you want to achieve")
										.font(.title3)
										.fontWeight(.medium)
										.foregroundColor(Color.white).opacity(0.9)
									Spacer()
								}
								TextEditor(text: $description)
									.frame(minHeight: 50, maxHeight: 200)
									.clipShape(RoundedRectangle(cornerRadius: 10))
									.overlay(
										RoundedRectangle(cornerRadius: 5)
											.stroke(Color.gray).opacity(0.3)
									)
							}
							.roundedTile()
							.padding(.horizontal, geo.size.width * 0.05 / 2)
							
							VStack {
								HStack {
									Text("Subgoals (optional)")
										.font(.title3)
										.fontWeight(.medium)
										.foregroundColor(Color.white).opacity(0.9)
									Spacer()
									Image(systemName: "plus.app.fill")
										.onTapGesture(count: 1, perform: {
											
										})
										.foregroundColor(.white)
								}
								
								HStack {
									List {
										ForEach(subgoals) { subgoal in
											Text(subgoal.details)
										}
										.onDelete(perform: deleteSubgoal)
									}
									.frame(height: subgoals.count == 0 ? 80 : 150)
									.cornerRadius(10)
									
									Spacer()
								}
								
							}
							.roundedTile()
							.padding(.horizontal, geo.size.width * 0.05 / 2)
							
							VStack {
								HStack {
									Text("Choose category")
										.font(.title3)
										.fontWeight(.medium)
										.foregroundColor(Color.white).opacity(0.9)
									Spacer()
								}
								
								Divider().background(Color.white).padding([.vertical, .trailing])
				
									VStack(alignment: .center, spacing: 20) {
										HStack(spacing: 20) {
											ForEach(0 ..< categories.count / 2) { index in
												Button(action: {
													self.backgroundColor = categories[index].backgroundColor
													
												}) {
													let width = (geo.size.width - 4 * 30) / 3
													Text(categories[index].rawValue.capitalized)
														.allowsTightening(true)
														.minimumScaleFactor(0.05)
														.font(.body)
														.foregroundColor(Color.black)
														.padding()
														.frame(width: width, height: 50)
														.background(categories[index].backgroundColor)
														.cornerRadius(10)
												}
											}
										}
										HStack(spacing: 20) {
											ForEach(categories.count / 2 ..< categories.count - 1) { index in
												Button(action: {
													self.backgroundColor = categories[index].backgroundColor
													
												}) {
													let width = (geo.size.width - 4 * 30) / 3
													Text(categories[index].rawValue.capitalized)
														.allowsTightening(true)
														.minimumScaleFactor(0.05)
														.font(.body)
														.foregroundColor(Color.black)
														.padding()
														.frame(width: width, height: 50)
														.background(categories[index].backgroundColor)
														.cornerRadius(10)
												}
											}
										}
									}
									.padding(.bottom)
								
								if self.categoryIndex == categories.count - 1 {
									
									TextField("Name of a custom category", text: $category)
										.textFieldStyle(RoundedBorderTextFieldStyle())
									//User's image here
								}
							}
							.roundedTile()
							.padding(.horizontal, geo.size.width * 0.05 / 2)
							
							VStack {
								HStack {
									Text("Choose color scheme")
										.font(.title3)
										.fontWeight(.medium)
										.foregroundColor(Color.white).opacity(0.9)
									Spacer()
								}
								HStack {
									Text("Background color")
										.font(.body)
										.fontWeight(.light)
										.foregroundColor(Color.white).opacity(0.9)
									
									ColorPicker("", selection: $backgroundColor)
										.padding(.horizontal)
								}
								HStack {
									Text("Text color")
										.font(.body)
										.fontWeight(.light)
										.foregroundColor(Color.white).opacity(0.9)
	
									ColorPicker("", selection: $foregroundColor)
										.padding(.horizontal)
								}
							}
							.roundedTile()
							.padding(.horizontal, geo.size.width * 0.05 / 2)
							
							Spacer().frame(height: 250)
						}
					}
				
				//Navigation menu (add, go back)
				VStack {
					Spacer()
					HStack(spacing: geo.size.width * 0.25) {
						
						Button(action: {
							self.presentationMode.wrappedValue.dismiss()
						}) {
							Image(systemName: "arrow.backward")
							
						}
						.roundedShadowedButton()
						
						
						//Add button
						Button(action : {
							hobby.activities.insert(Activity(title: title, associatedImage: imageName, colorTheme: ColorTheme(backgroundColorHex: backgroundColor.toHex() ?? "#000000", foregroundColorHex: foregroundColor.toHex() ?? "#ffffff"), subgoals: subgoals), at: 0)
							self.presentationMode.wrappedValue.dismiss()
						}) {
							Image(systemName: "plus")
						}
						.roundedShadowedButton()
						.disabled(disableApplyButton)
						.opacity(disableApplyButton ? 0.6 : 1)
						
						
						
					}
					.transparentNavigationBar()
				}
				.edgesIgnoringSafeArea(.bottom)
			}
		}
	}
	
	func deleteSubgoal(at offsets: IndexSet) {
		subgoals.remove(atOffsets: offsets)
	}
}



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(hobby: Hobby())
    }
}


struct TileStackModifier: ViewModifier {
	func body(content: Content) -> some View {
		
		content
			.padding()
			.background(Color(hex: "#9B5DE5").opacity(0.9))
			.cornerRadius(15)

			.shadow(color: Color.black.opacity(0.08), radius: 5)
			
	}
}
extension View {
	func roundedTile() -> some View {
		self.modifier(TileStackModifier())
	}
}





