//
//  GenerationPassword.swift
//  BruteForceTask
//
//  Created by MAC on 08.01.2022.
//
import UIKit

class GenerationPassword: Operation {
    
    var password: String
    
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
    
    func bruteForce(passwordToUnlock: String) {
        
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        
        print(password)
    }
    
    // MARK: - Numerical sampling method
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character)) ?? 0
    }
    
    // MARK: - Character sampling method
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
            : Character("")
    }
    
    // MARK: - String sampling method
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last ?? ".", array) + 1) % array.count, array))
            
            if indexOf(character: str.last ?? ".", array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last ?? ".")
            }
        }
        
        return str
    }
}
