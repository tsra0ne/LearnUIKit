//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var textField = UITextField()
    var doneButton = UIButton()
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        setupTextField()
        setupButton()
        setupLabel()
        view.addSubviews(textField, doneButton, label)
        setupConstraints()
    }
    
    func setupTextField() {
        textField.placeholder = "Enter text here..."
        textField.borderStyle = .roundedRect
        // Make Secure Text Field
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .always
//        textField.keyboardType = .namePhonePad
        textField.keyboardAppearance = .dark
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.returnKeyType = .go
        textField.clearsOnBeginEditing = true
        textField.enablesReturnKeyAutomatically = true
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneItemTapped))
        let spacerButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spacerButtonItem, doneButtonItem], animated: false)
        
        textField.inputAccessoryView = toolbar
    }
    
    func setupButton() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.backgroundColor = .green
        doneButton.startAnimatingPressActions()
    }
    
    func setupLabel() {
        label.textAlignment = .center
    }
    
    func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(250)
        }
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.trailing).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(textField)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc func doneTapped() {
        textField.resignFirstResponder()
        guard let textContent = textField.text else { return }
        label.text = textContent
    }
    
    @objc func doneItemTapped() {
        textField.resignFirstResponder()
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only alphanumeric characters
        let allowedCharacters = CharacterSet.alphanumerics
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
    
}
