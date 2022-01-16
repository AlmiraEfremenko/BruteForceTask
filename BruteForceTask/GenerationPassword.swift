//
//  GenerationPassword.swift
//  BruteForceTask
//
//  Created by MAC on 08.01.2022.
//
import UIKit

/**
 This class generates a password and is used to pass to the OperationQueue
 */

class GenerationPassword: Operation {
    
    private var password: String
    
    init(password: String) {
        self.password = password
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        bruteForce(passwordToUnlock: password)
    }
    
    // MARK: - Setting password generation

    /// This password guessing function
    /// - Parameter passwordToUnlock: password guessing parameter
    
    private func bruteForce(passwordToUnlock: String) {
        
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        print(password)
    }
    
    // MARK: - Method of fetching characters by index
    
    /// Method to iterate over characters and return the element at the first index
    /// - Parameters:
    ///   - character: character iteration
    ///   - array: the array of strings
    /// - Returns: the first index in the array
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? 0
    }
    
    // MARK: - Character sampling method
    
    /// Method to iterate over characters in an array at the index
    /// - Parameters:
    ///   - index: iteration index
    ///   - array: character array
    /// - Returns: character
    
    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }
    
    // MARK: - String sampling method
    
    /// Password string generation method
    /// - Parameters:
    ///   - string: iteration string
    ///   - array: array string of elements
    /// - Returns: generation string password
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var generationString = string
        
        if generationString.count <= 0 {
            generationString.append(characterAt(index: 0, array))
        } else {
            generationString.replace(at: generationString.count - 1,
                        with: characterAt(
                            index: (indexOf(
                                        character: generationString.last ?? " ", array) + 1) % array.count, array))
            
            if indexOf(character: generationString.last ?? " ", array) == 0 {
                generationString = String(generateBruteForce(String(generationString.dropLast()), fromArray: array)) + String(generationString.last ?? " ")
            }
        }
        return generationString
    }
}
