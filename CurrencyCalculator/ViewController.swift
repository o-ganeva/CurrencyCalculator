//
//  ViewController.swift
//  CurrencyCalculator
//
//  Created by Olya Ganeva on 04.11.2020.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let spacing: CGFloat = 8
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vStackView = createAndSetupVStackView()
        
        setupTextField(into: vStackView)
        
        var hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "C", color: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "+/-", color: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "%", color: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "/", color: .orange)
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "7", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "8", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "9", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "*", color: .orange)
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "4", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "5", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "6", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "-", color: .orange)
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "1", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "2", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "3", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "+", color: .orange)
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupDoubleButton(into: hStackView, withTitle: "0", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: ",", color: .darkGray)
        createAndSetupButton(into: hStackView, withTitle: "=", color: .orange)
    }
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - spacing * 5) / 4
    }
    
    func setupTextField(into stackView: UIStackView) {
        textField.font = .systemFont(ofSize: 60)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 40
        textField.textAlignment = .right
        stackView.addArrangedSubview(textField)
    }
    
    func createAndSetupVStackView() -> UIStackView {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = spacing
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(spacing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(spacing)
        }
        return vStackView
    }
    
    func createAndSetupHStackView(into stackView: UIStackView) -> UIStackView {
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.spacing = spacing
        stackView.addArrangedSubview(hStackView)
        hStackView.snp.makeConstraints {
            $0.height.equalTo(buttonWidth())
        }
        return hStackView
    }
    
    func createAndSetupButton(into stackView: UIStackView, withTitle title: String, color: UIColor) {
        let button = createButton(withTitle: title, color: color)
        stackView.addArrangedSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(buttonWidth())
        }
    }
    
    func createAndSetupDoubleButton(into stackView: UIStackView, withTitle title: String, color: UIColor) {
        let doubleButton = UIButton()
        let button = createButton(withTitle: title, color: color)
        doubleButton.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(buttonWidth())
            $0.left.top.bottom.equalToSuperview()
        }
        doubleButton.layer.cornerRadius = buttonWidth() / 2
        doubleButton.backgroundColor = color
        stackView.addArrangedSubview(doubleButton)
    }
    
    func createButton(withTitle title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = buttonWidth() / 2
        button.titleLabel?.font = .systemFont(ofSize: 40)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.addTarget(self, action: #selector(handler), for: .touchUpInside)
        return button
    }
    
    ///
    
    var operation = ""
    var firstOperand = ""
    var secondOperand = ""
    var isPercentTapped = false
    
    @objc func handler(sender: UIButton) {
        let value = sender.title(for: .normal)!
        handle(value)
    }
    
    func handle(_ value: String) {
        if "0123456789".contains(value) {
            if operation.isEmpty {
                if isPercentTapped {
                    isPercentTapped = false
                    firstOperand = ""
                }
                firstOperand += value
                textField.text = firstOperand
            } else {
                if isPercentTapped {
                    isPercentTapped = false
                    secondOperand = ""
                }
                secondOperand += value
                textField.text = secondOperand
            }
            
        } else if "/*+-".contains(value) {
            operation = value
            
            if !secondOperand.isEmpty {
                firstOperand = calculate(firstOperand.doubleValue, secondOperand.doubleValue, operation).stringValue
                textField.text = firstOperand
                secondOperand = ""
            }
            
        } else if value == "=" {
            firstOperand = calculate(firstOperand.doubleValue, secondOperand.doubleValue, operation).stringValue
            textField.text = firstOperand
            operation = ""
            secondOperand = ""
            
        } else if value == "C" {
//            TODO: Make AC
            textField.text = ""
            operation = ""
            firstOperand = ""
            secondOperand = ""
            
        } else if value == "," {
            if operation.isEmpty {
                if !firstOperand.contains(value) {
                    firstOperand += value
                    textField.text = firstOperand
                }
            } else {
                if !secondOperand.contains(value) {
                    secondOperand += value
                    textField.text = secondOperand
                }
            }
        } else if value == "%" {
            isPercentTapped = true
            
            if !firstOperand.isEmpty && operation.isEmpty {
                firstOperand = (firstOperand.doubleValue / 100.0).stringValue
                textField.text = firstOperand
            } else if !secondOperand.isEmpty {
                secondOperand = (firstOperand.doubleValue / 100.0 * secondOperand.doubleValue).stringValue
                textField.text = secondOperand
            }
        }
    }
    
    func calculate(_ first: Double, _ second: Double, _ operation: String) -> Double {
        if operation == "+" {
            return first + second
        } else if operation == "-" {
            return first - second
        } else if operation == "/" {
            return first / second
        } else if operation == "*" {
            return first * second
        } else {
            fatalError()
        }
    }
}

extension String {
    var doubleValue: Double {
        if self.isEmpty { return 0 }
        return Double(self.replacingOccurrences(of: ",", with: "."))!
    }
}

extension Double {
    var stringValue: String {
        if floor(self) == self {
            return String(Int(self))
        } else {
            let s = String(format: "%.2f", self)
            return s.replacingOccurrences(of: ".", with: ",")
        }
    }
}



