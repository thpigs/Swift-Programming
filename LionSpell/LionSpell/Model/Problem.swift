//
//  Problem.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/9/24.
//

import Foundation

struct Problem {
    var letterAmount : Int
    var playerLetters = ""
    var correctWordSet = Set<String>()
    var totalPoints = 0
    var panagramNum = 0
    
    // Appropriately chooses 5 unique letters that spell at least one 5 letter word
    mutating func generateLetters(language: Language) {
        let words = getWords(for: language)
        // Set of 5 letter words with unique characters
        let validFiveLetterWords = Set(words.filter { $0.count == letterAmount && Set($0).count == letterAmount })
        // Selects random 5 letter word and shuffles it
        playerLetters = String(Array(validFiveLetterWords).randomElement()!.shuffled())
        findCorrectWords(letters: playerLetters, language: language)
    }
    
    // Creates set of all possible words with the given letters and Words model
    mutating func findCorrectWords(letters: String, language: Language) {
        let letterSet = Set(letters)
        let words = getWords(for: language)
        
        let firstLetter = letters.first
        // Filter words that can be formed using playerLetters
        correctWordSet = Set(words.filter { word in
            word.contains(firstLetter!) && Set(word).isSubset(of: letterSet)
        })
        //print("Correct Word Set: \(correctWordSet)")
    }
    
    func getWords(for language: Language) -> [String] {
        switch language {
        case .english:
            return Words.words
        case .french:
            return Words.frenchWords
        }
    }
}

