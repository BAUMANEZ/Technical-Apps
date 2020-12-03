//
//  ContentView.swift
//  Views and Modifiers
//
//  Created by Арсений Токарев on 08.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 17))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
                content
                Text(text)
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(1)
                    .background(Color.white)
                
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct GreetingView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .titleStyle()
    }
}

struct BlueTitle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
            .padding(4)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func blueTitle(with color: Color = Color.clear) -> some View {
        self.modifier(BlueTitle(color: color))
    }
}

struct ContentView: View {
    @State private var useBlackText = false
    
    //this is a weird construction, but it is an illustative examples of all technologies I have learned from the guide
    var greeting = GreetingView(text: "Hello, world!!!")
    
    var body: some View {
        ZStack {
            Color(red: 0.92, green: 0.9, blue: 1).edgesIgnoringSafeArea(.all)
            VStack {
                greeting
                    .watermarked(with: "from swift")
                Color.blue
                    .frame(width: 300, height: 200)
                    .watermarked(with: "Hacking with Swift")
                
                Button("Push me") {
                    self.useBlackText.toggle()
                }
                    .font(.largeTitle)
                    .foregroundColor(useBlackText ? .black : .white)
                    .padding(5)
                    .background(useBlackText ? Color.white : Color.black)
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                    .overlay(useBlackText ? Capsule().stroke(Color.black, lineWidth: 2) : Capsule().stroke(Color.white, lineWidth: 2))
                .padding(30)
                Text("Prominent Blue Title")
                    .blueTitle(with: Color(red: 0.6, green: 2, blue: 0.8))
                Spacer()
            }
            .blur(radius: 0.2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
