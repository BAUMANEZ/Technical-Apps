//
//  ResultsView.swift
//  Mathiplication
//
//  Created by Арсений Токарев on 31.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    var body: some View {
		ZStack {
			BackgroundImageView(color: .pink)
			VStack {
				Text("Results: ")
			}
		}
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
