//
//  ContentView.swift
//  Animations
//
//  Created by Арсений Токарев on 17.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
    }
}


extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var rotationAmount = 0.0
    @State private var dragAmount = CGSize.zero
    @State private var cardIsShown = true
    
    var body: some View {
        VStack(spacing: 50) {
            Button("Hide/Show") {
                withAnimation {
                    self.rotationAmount += 360
                }
                
                withAnimation {
                    self.cardIsShown.toggle()
                }
            }
            .foregroundColor(.black)
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .padding(40)
            .background(Color.green)
            .clipShape(Circle())
            .shadow(color: .green, radius: 3)
            .overlay(
                    Circle()
                        .stroke(Color.green)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: false)
                        )
            )
            .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 0, z: 1))
            .onAppear {
                self.animationAmount = 2
            }
            
            if cardIsShown {
                Text("I am a movable text")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .frame(width: 300, height: 200, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 2)
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged {
                                self.dragAmount = $0.translation
                            }
                            .onEnded { _ in
                                self.dragAmount = .zero
                            }
                    )
                    .animation(.spring())
					.transition(.move(edge: .leading))
            }
            
        } //VStack
        
    } // body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
