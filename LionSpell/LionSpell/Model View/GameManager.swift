//
//  GameManager.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/9/24.
//

import Foundation

class GameManager: ObservableObject {
    // The letters the player is given to build words
    @Published var letterChoices: [String]
    @Published var wordBuilder = ""
    @Published var submittedWords: [String] = []
    @Published var emptyAnswer: Bool = true
    @Published var isCorrect: Bool = false
    @Published var score: Int = 0
    @Published var showSettings: Bool = false
    @Published var wordLengthHint: [Int: [Character: Int]] = [:]
    @Published var showHints: Bool = false
    
    @Published var preferences: Preferences {
        didSet {
            newGame()
        }
    }
    @Published var problem: Problem
    
    init(problem: Problem, preferences: Preferences) {
        
        self.preferences = Preferences(numberOfLetters: .five, language: .english)
        self.problem = Problem(letterAmount: preferences.numberOfLetters.rawValue)
        self.letterChoices = []
        newGame()
    }
    
    private func toggleDelSubButtons () {
       emptyAnswer = wordBuilder.isEmpty
       isCorrect = self.problem.correctWordSet.contains(wordBuilder)
    }
    
    func submit() {
        toggleDelSubButtons()
        if self.isCorrect && !submittedWords.contains(wordBuilder){
            updateScore(submittedWord: wordBuilder)
            submittedWords.append(wordBuilder)
            wordBuilder = ""
        }
        toggleDelSubButtons()
        
    }
    
    func deleteLetter () {
        if (!wordBuilder.isEmpty) {
            wordBuilder.removeLast()
            toggleDelSubButtons()
        }
    }
    
    func addLetter(letter: String) {
        wordBuilder.append(letter)
        toggleDelSubButtons()
    }
    
    func shuffle() {
        let mainButton = letterChoices[0]
        let otherButtons = letterChoices.dropFirst().shuffled()
        
        letterChoices = [mainButton] + otherButtons
    }
    
    func newGame() {
        problem = Problem(letterAmount: preferences.numberOfLetters.rawValue)
        
        problem.generateLetters(language: preferences.language)
        countPanagrams()
        calcWordLengthHint()
        problem.totalPoints = totalPoints(correctWordSet: problem.correctWordSet)
        letterChoices = Array(self.problem.playerLetters).map {
            String($0)
        }
        self.problem.findCorrectWords(letters: problem.playerLetters, language: preferences.language)
        self.wordBuilder = ""
        self.submittedWords = []
        self.score = 0
        toggleDelSubButtons()
    
    }
    
    func hint() {
        showHints.toggle()
        print("hints presed")
    }
    
    func settings() {
        showSettings.toggle()
        print("Setting Button pressed")
    }
    
    private func updateScore(submittedWord: String) -> Int {
        let letterSet = Set(letterChoices)
        let submittedWordSet = Set(submittedWord)
        var pangram = true
        
        for letter in letterSet {
            if !submittedWordSet.contains(letter) {
                pangram = false
                break;
            }
        }
        
        if submittedWord.count == 4 {
            score += 1
            return 1
        }
        else if pangram {
            score += 10 + submittedWord.count
            return 10 + submittedWord.count
        } else {
            score += submittedWord.count
            return submittedWord.count
        }
    }
    
    func totalPoints(correctWordSet: Set<String>) -> Int{
        var totalPoints = 0
        
        for word in correctWordSet {
            totalPoints += updateScore(submittedWord: word)
        }
        return totalPoints
    }
    
    func countPanagrams() {
        for word in problem.correctWordSet {
            var panagram = true
            for letter in Set(letterChoices) {
                if !problem.correctWordSet.contains(letter) {
                    panagram = false
                    break
                }
            }
            if panagram {
                problem.panagramNum += 1
            }
            
        }
    }
    
    func calcWordLengthHint() {
        // Resets before calculating new hints
        wordLengthHint = [:]
        
        // Iterating through all correct words
        for word in problem.correctWordSet {
            let length = word.count
            let letter = word.first ?? " "
            
            // Check if there is already an entry for this length
            if wordLengthHint[length] == nil {
                wordLengthHint[length] = [:]
            }
            
            // Check if nested dict already has an entry for this letter
            if wordLengthHint[length]?[letter] == nil {
                wordLengthHint[length]?[letter] = 0
            }
            
            // Increment the count for the letter and length
            wordLengthHint[length]?[letter]? += 1
        }
    }
}

