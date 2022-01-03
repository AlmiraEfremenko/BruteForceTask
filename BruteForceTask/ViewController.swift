//
//  ViewController.swift
//  BruteForceTask
//
//  Created by MAC on 03.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonGeneration: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let operation = GenerationPassword()
    let queue = OperationQueue()
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }
    
    @IBAction func onButtonGeneration(_ sender: Any) {
        self.indicator.startAnimating()
        self.indicator.hidesWhenStopped = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if self.textField.text != "" {
                self.queue.addOperation(self.operation)
                self.label.text = self.textField.text
                self.textField.isSecureTextEntry = false
                self.buttonGeneration.isEnabled = false
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        textField.isSecureTextEntry = true
        label.text = "Здесь появится ваш пароль"
        buttonGeneration.setTitle("Сгенерировать", for: .normal)
        buttonGeneration.setTitle("Пароль сгенерирован", for: .disabled)
    }
}

class GenerationPassword: Operation {
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
            : Character("")
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
}

extension String {
    var digits: String { return "0123456789" }
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { return lowercase + uppercase }
    var printable: String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
