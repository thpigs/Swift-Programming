//
//  GameManager.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/23/24.
//

import Foundation
class GameManager: ObservableObject {
    //@Published var that need to be used by other views....
    @Published var pieces: [Piece] = []
    @Published var startPos: [CGPoint] = []
    @Published var puzzleOutlines: [PuzzleOutline] = []
    @Published var solutions: [String: [String: Position]] = [:]
    @Published var gridSize: (Int, Int) = (14, 14)
    @Published var unitSize: CGFloat = 600/14
    @Published var currPuzzle: PuzzleOutline?
    
    
    
    init() {
        // PentominoOutlines is a list of PentominoOutline structs, which is a member of the piece struct. readme says to load position with default value, so this pentominoOutline member gets loaded from the json.
        if let temp: [PentominoOutline] = loadData(jsonName: "PentominoOutlines", type: [PentominoOutline].self) {
            pieces = temp.map { PentominoOutline in
                            return Piece(outline: PentominoOutline)
                        }
        }
        
        if let temp: [PuzzleOutline] = loadData(jsonName: "PuzzleOutlines", type: [PuzzleOutline].self) {
            puzzleOutlines = temp
        }
        
        if let temp: [String: [String: Position]] = loadData(jsonName: "Solutions", type: [String: [String: Position]].self) {
            solutions = temp
        }
        
        currPuzzle = puzzleOutlines[0]
        //checkContents()
        loadShapes()
    }
    
    func loadShapes() {
        
    }
    
    func changePuzzle(num: Int) {
        currPuzzle = puzzleOutlines[num]
    }
    
    // Debugging helper
    func checkContents() {
        /*
        print("pieces: ")
        for x in pieces {
            print(x)
        }
         */
        print("puzzleOutline: ")
        for x in puzzleOutlines {
            print(x)
        }
    }
    
    func showSolution() {
        guard let puzzleName = currPuzzle?.name else { return }
        // Dictionaries
        guard let puzzleSolutions = solutions[puzzleName] else { return }
        
        for (index, piece) in pieces.enumerated() {
            let pieceName = piece.outline.name
            if let pieceSolution = puzzleSolutions[pieceName] {
                let x = pieceSolution.x * Int(unitSize)
                let y = pieceSolution.y * Int(unitSize)
                let orientation = pieceSolution.orientation
                
                let pos = Position(x: x, y: y, orientation: orientation)

                pieces[index].position = pos
                print("\(pieceName) should move to \(pos)")
            }
            
        }

    }
    
    func reset() {
        
    }
    
    
    // JSON READER
    private func loadData<T: Codable> (jsonName: String, type: T.Type) -> T? {
        // Checking docucments folder first. If nothing found, check bundle
        let fileURL = URL.documentsDirectory.appendingPathComponent(jsonName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let content = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                return try decoder.decode(type, from: content)
            }
            catch {
                print(error)
                return nil
            }
        }
        
        // Nothing found in documents directory, checking app bundle instead
        let bundle = Bundle.main
        let url = bundle.url(forResource: jsonName, withExtension: "json")
        
        guard let url = url else {return nil}
        
        do {
            let content = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: content)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    
}
