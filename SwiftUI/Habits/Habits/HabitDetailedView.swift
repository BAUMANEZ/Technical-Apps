//
//  HabitDetailedView.swift
//  Habits
//
//  Created by Арсений Токарев on 27.09.2020.
//

import SwiftUI




struct HabitDetailedView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var hobby: Hobby
	
	@State private var description: String = ""
	@State private var editButtonIsPressed = false
	@State private var updateStatus: Int = 5
	@State private var progressStatus = Int.random(in: 5 ... 100)
	
	let backgroundColor: Color
	let activityIndex: Int
	
    var body: some View {
		ZStack {
			backgroundColor.opacity(0.4).edgesIgnoringSafeArea(.all)
			GeometryReader { geo in
				ScrollView(.vertical) {
					VStack {
						Image(hobby.activities[activityIndex].associatedImage)
							.resizable()
							.scaledToFill()
							.frame(height: geo.size.width * 0.5)
							.padding()
						Spacer()
						
						VStack(alignment: .leading) {
							VStack {
								HStack {
										if editButtonIsPressed {
											TextField("Title", text: $hobby.activities[activityIndex].title)
												.font(.system(.largeTitle))
												.padding([.vertical, .leading])
										} else {
											Text(hobby.activities[activityIndex].title)
												.font(.largeTitle)
												.fontWeight(.bold)
												.lineLimit(2)
												.allowsTightening(true)
												.minimumScaleFactor(0.005)
												.multilineTextAlignment(.leading)
												.padding([.vertical, .leading])
										}
									
									Spacer()
									
									//MARK: edit mode
									Image(systemName: editButtonIsPressed ? "pencil.circle.fill" : "pencil.circle")
										.resizable()
										.frame(width: 40, height: 40)
										.padding(.trailing)
										.onTapGesture {
											withAnimation(.spring()) {
												self.editButtonIsPressed.toggle()
											}
											
											if !editButtonIsPressed {
												self.updateStatus = 0
											}
										}
								}
								VStack(spacing: 10) {
									HStack {
										Image(systemName: "arrow.triangle.2.circlepath.circle")
											.padding(.leading)
										Text("Updated: \(updateStatus) minutes ago")
											.font(.footnote)
											.fontWeight(.light)
										Spacer()
									}
									HStack {
										Image(systemName: "timer")
											.padding(.leading)
										Text("Progress: \(progressStatus)%")
											.font(.footnote)
											.fontWeight(.light)
										Spacer()
									}
								}
							}
							
							Divider().padding()
							
							Text("Description")
								.font(.title3)
								.fontWeight(.medium)
								.padding([.leading, .bottom])
							
							
							Text(hobby.activities[activityIndex].description ?? "There is no description")
								.font(.system(Font.TextStyle.callout, design: Font.Design.serif))
								.multilineTextAlignment(.leading)
								.padding([.horizontal, .bottom])
							
							Divider().padding()
							
							Text("Images")
								.font(.title3)
								.fontWeight(.medium)
								.padding([.leading, .bottom])
							ScrollView(.horizontal) {
								HStack {
									Image("addImage")
										.resizable()
										.frame(width: 50, height: 50)
										.scaledToFill()
										.background(Color(.systemGray6))
										.padding(.horizontal)
										.onTapGesture(count: 3, perform: {
											fatalError("Cringe")
										})
									Spacer()
								}
							}
							Divider().padding()
							
							// a scroll of information about hobby covers the entire height of the screen
							Spacer().frame(minHeight: 150)
						}
						.frame(width: geo.size.width * 0.95)
						.background(Color(.white).opacity(0.925))
						.cornerRadius(15)
						.shadow(color: Color.black.opacity(0.25), radius: 10)
						.offset(y: -geo.size.height * 0.025)
						
					}
				}
				VStack {
					Spacer()
					HStack(spacing: geo.size.width * 0.25) {
						Button(action : {
							presentationMode.wrappedValue.dismiss()
							hobby.deleteActivity(hobby.activities[activityIndex])
						}) {
							Image(systemName: "trash")
						}
						.roundedShadowedButton()
						
						
						
						Button(action: {
							presentationMode.wrappedValue.dismiss()
						}) {
							Image(systemName: "arrow.backward")
								
						}
						.roundedShadowedButton()
					}
					.transparentNavigationBar()
				}
				.edgesIgnoringSafeArea(.bottom)
			}
		}
    }
	
}

struct HabitDetailedView_Previews: PreviewProvider {
	static let hobby = Hobby()
    static var previews: some View {
		HabitDetailedView(hobby: hobby, backgroundColor: .yellow, activityIndex: 0)
    }
}




