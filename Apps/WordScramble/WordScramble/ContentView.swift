//
//  ContentView.swift
//  WordScramble
//
//  Created by Арсений Токарев on 16.08.2020.
//  Copyright © 2020 Арсений Токарев. All rights reserved.
//

import SwiftUI


struct scoreTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(red: 50 / 255, green: 50 / 255, blue: 50 / 255))
            .frame(width: 125, height: 35, alignment: .center)
            .padding(15)
            .background(Color(red: 255 / 255, green: 253 / 255, blue: 168 / 255))
            .clipShape(Capsule())
    }
}

extension View {
    func scoreTitle() -> some View {
        self.modifier(scoreTitleModifier())
    }
}


struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var totalScore = 0
    @State private var infoAlert = false
    
    let infoString =
    """
    You are given point according to the following rules:
        1. Words made of 3 letters give you 1 point;
        2. Words made of 3 - 4 letters give you 2 points;
        3. Words made of 5 and more letters give you 2 points.
    """
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a word", text: $newWord, onCommit: addNewWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                    
                
                List(usedWords, id: \.self ) {
                    Image(systemName: "\($0.count).circle.fill")
                    Text("\($0)")
                }
                
                Section {
                    VStack {
                        Text("Total score")
                            .font(.system(size: 25, weight: .medium, design: .default))
                        Text("\(totalScore)")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                    }
                    .scoreTitle()
                    .overlay(Capsule().stroke(Color(.brown), lineWidth: 1.5))
                    .shadow(color: Color(.brown), radius: 0.5)
                }
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing:
                HStack(spacing: 15) {
                    Button(action: {
                        /*
                        self.infoAlert = true
                         TO BE DONE
                         */
                    }) {
                        Image(systemName: "questionmark")
                    }
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .frame(width: 15, height: 5, alignment: .center)
                        .padding()
                        .background(Color(.systemGray4))
                        .clipShape(Capsule())
                    
                    Button(action: {
                        self.startGame()
                    }) {
                        Image(systemName: "arrow.uturn.left")
                    }
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .frame(width: 15, height: 5, alignment: .center)
                        .padding()
                        .background(Color(red: 129/255, green: 218/255, blue: 62/255))
                        .clipShape(Capsule())
                } //HStack(NavBarItems)
                .shadow(radius: 2.5)
                
            ) //navigationBarItems
                
            .onAppear(perform: startGame)
                
                
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
            
        } //NavigationView
        
    } //body
    
    func startGame() {
        newWord = ""
        usedWords = []
        totalScore = 0
        //Trying to find the start.txt from the app bundle
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //Read contents of start.txt into string
            if let startWords = try? String(contentsOf: startWordURL) {
                //Make an array of words from the string
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                //If we are here we can exit
                return
            }
        }
        //If we are HERE we throw an error
        fatalError("Couldn't load a file from URL")
    } //startGame()
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
        
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addNewWord() {
      // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
         //Make sure that the word has more than 3 letters
         guard newWord.count >= 3 else {
            wordError(title: "Wrong answer", message: "The word should have more than 3 letters")
            return
        }
        
        guard newWord != rootWord else {
            wordError(title: "Wrong answer", message: "You cannot use a root word as an answer")
            return
        }
        
        guard isOriginal(word: newWord) else {
            wordError(title: "Word has already been used", message: "Be more original!")
            return
        }
        
        guard isPossible(word: newWord) else {
            wordError(title: "Wrong answer", message: "You cannot just make words up!")
            return
        }
        
        guard isReal(word: newWord) else {
            wordError(title: "Wrong answer", message: "This is not a word!")
            return
        }
        
        
        usedWords.insert(answer, at: 0)
        switch newWord.count {
        case 3 :
            totalScore += 1
        case 4 ..< 6 :
            totalScore += 2
        case 6... :
            totalScore += 3
        default :
            return
        }
        
        newWord = ""
    } //addNewItem()
    
} //ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
