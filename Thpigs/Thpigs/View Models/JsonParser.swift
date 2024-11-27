//
//  JsonParser.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import Foundation
class JsonParser : ObservableObject {
    /*
     func readJson(file: String) -> [Pokemon]? {
        let fileURL = URL.documentsDirectory.appendingPathComponent(file)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let content = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                return try decoder.decode([Pokemon].self, from: content)
            }
            catch {
                print(error)
                return nil
            }
        }
            
        // Nothing found in documents directory, checking app bundle instead
        let bundle = Bundle.main
        let url = bundle.url(forResource: file, withExtension: "json")
                
        guard let url = url else {return nil}
                
        do {
            let content = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Pokemon].self, from: content)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    
    func saveUserData(pokedex: [Pokemon], file: String) {
        //print("saving")
        let fileURL = URL.documentsDirectory.appendingPathComponent(file)
        guard let jsonData = serializeData(data: pokedex) else {
            print("fail 1")
            return;
        }
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try jsonData.write(to: fileURL)
                print("exists")
                //print("2")
            } else {
                FileManager.default.createFile(atPath: fileURL.path, contents: jsonData)
                print("writing new")
                //print("3")
            }
        } catch {
            print("writing failed")
        }
    }
    
    func serializeData(data: [Pokemon]) -> Data? {
        let encoder = JSONEncoder()
        let jsonData: Data
        do {
            jsonData = try encoder.encode(data)
            //print("good serialize")
            /*if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Serialized JSON Data: \(jsonString)")
            }*/
        } catch {
            print("Failed to encode JSON: \(error)")
            return nil
        }
        
        return jsonData
    }
    */
}
