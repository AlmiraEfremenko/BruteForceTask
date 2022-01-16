//
//  ViewController.swift
//  BruteForceTask
//
//  Created by MAC on 03.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var buttonColorView: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonOfGenerationPassword: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let queue = OperationQueue()
    
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
        setupViewBruteForcePassword()
        
        // Присвоение значения textField константе passwordBruteForce
        let passwordBruteForce = textField.text ?? " "
        
        // Здесь радробили массив из строк на кусочки по 2 символа с помощью метода split
        let passwordSplit = passwordBruteForce.split(by: 2)
        
        var arrayGenerationPassword = [GenerationPassword]()
        
        // Каждый кусочек по 2 символа из массива отправляется в операцию
        passwordSplit.forEach { i in
            arrayGenerationPassword.append(GenerationPassword(password: i))
        }
        
        // Каждая операция отправляется в очередь
        arrayGenerationPassword.forEach { i in
            queue.addOperation(i)
        }
        
        queue.addBarrierBlock { [unowned self] in
            OperationQueue.main.addOperation {
                self.setupViewCompleteBruteForcePassword()
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.hidesWhenStopped = true
        label.text = "Здесь появится ваш пароль"
        setupButtonGenerationPassword()
    }
    
    // MARK: - Settings
    
    private func setupButtonGenerationPassword() {
        buttonOfGenerationPassword.setTitle("Сгенерировать пароль", for: .normal)
        buttonOfGenerationPassword.setTitle("Подбор пароля", for: .disabled)
    }
    
    private func setupViewBruteForcePassword() {
        textField.text = String.random(length: 10)
        textField.isSecureTextEntry = true
        indicator.startAnimating()
        buttonOfGenerationPassword.isEnabled = false
    }
    
    private func setupViewCompleteBruteForcePassword() {
        label.text = self.textField.text
        textField.isSecureTextEntry = false
        buttonOfGenerationPassword.isEnabled = true
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}
