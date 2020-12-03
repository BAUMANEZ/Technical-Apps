//
//  SwiftUIView.swift
//  Habits
//
//  Created by Арсений Токарев on 21.10.2020.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
		LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.yellow]), startPoint: .bottom, endPoint: .top)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
