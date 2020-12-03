//
//  PifagorTableView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 26.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct PifagorTableView: View {
	@EnvironmentObject var game: GameData
    var body: some View {
		ZStack {
			BackgroundImageView(color: .blue)
			VStack(spacing: 25) {
				Button("To be improved") {
					withAnimation(Animation.spring().delay(0.15)) {
						self.game.infoIsShown.toggle()
					}
				}
					//.font(.system(size: 45))
					.foregroundColor(.white)
					.padding()
					.background(Color.red)
					.clipShape(RoundedRectangle(cornerRadius: 10))
				
				HStack {
					//Spacer()
					Text(" ").frame(width: 24, height: 20)
					ForEach(1 ..< 13) { number in
						Text(String(number))
							.frame(width: 24, height: 30)
							.background(Color.yellow)
							.clipShape(RoundedRectangle(cornerRadius: 5))
						
					}
				}
				ForEach(1 ..< 13) { row in
					HStack {
						Text(String(row))
							.frame(width: 24, height: 30)
							.background(Color.green)
							.clipShape(RoundedRectangle(cornerRadius: 5))
						ForEach(1 ..< 13) { col in
							Text(String(col*row))
								.font(.system(size: 13))
								.frame(width: 24, height: 30)
								.background(Color.orange)
								.clipShape(RoundedRectangle(cornerRadius: 5))
								
						}
					}
				}
			}
		}
    }
}

struct PifagorTableView_Previews: PreviewProvider {
    static var previews: some View {
		PifagorTableView().environmentObject(GameData())
    }
}
