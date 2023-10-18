//
//  ContentView.swift
//  WordScramble
//
//  Created by Ivan Tilev on 17.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        // 1. Lowercasing the answer and trimming it from whitespaces
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // 2. Check if there is more than 1 letter in the answer
        guard answer.count > 0 else { return }
        // 3. Exttra validation to come
        
        // 4. Insert the answet to the array of answer to keep track of them
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        // 5. Reseting newWord to be empty string
        newWord = ""
    }
    
    // Starting a game method
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
