//
//  ViewController.swift
//  BruteForceTask
//
//  Created by MAC on 03.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonOfGenerationPassword: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let queue = OperationQueue()
    private let mainQueue = OperationQueue.main
    
    private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func buttonOfChangeColorView(_ sender: Any) {
        isBlack.toggle()
    }
    
    @IBAction func buttonOfGenerationPassword(_ sender: Any) {
        self.textField.text = String.random()
        
        if self.textField.text != "" {
            textField.isSecureTextEntry = true
            let passwordSelection = GenerationPassword(password: textField.text ?? "")
            indicator.startAnimating()
            buttonOfGenerationPassword.isEnabled = false
            queue.addOperation(passwordSelection)
            
            let operationBlock = BlockOperation {
                self.label.text = self.textField.text
                self.textField.isSecureTextEntry = false
                self.buttonOfGenerationPassword.isEnabled = true
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
            
            passwordSelection.completionBlock = {
                self.mainQueue.addOperation(operationBlock)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        label.text = "Здесь появится ваш пароль"
        buttonOfGenerationPassword.setTitle("Сгенерировать пароль", for: .normal)
        buttonOfGenerationPassword.setTitle("Подбор пароля", for: .disabled)
    }
}
