//
//  ViewController.swift
//  CurrencyCalculator
//
//  Created by Olya Ganeva on 04.11.2020.
//

import UIKit
import SnapKit

enum Operation: String {
    case add = "􀅼"
    case subtract = "􀅽"
    case multiply = "􀅾"
    case divide = "􀅿"
}

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    let spacing: CGFloat = 12
    let textField = UITextField()
    let currencyTextField = UITextField()
    var currency: Currency?
    let charaterLimit = 10
    var inLabel = UILabel()
    var outLabel = UILabel()
    var isRubActive = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        fromRubToUsd()
        
        let vStackView = createAndSetupVStackView()
        let upperStackView = createAndSetupUpperStackView(stackView: vStackView)
//        let hCurrencyStackView = createAndSetupHCurrencyStackView(into: upperStackView)
//        let hCurrencyStackView2 = createAndSetupHCurrencyStackView(into: upperStackView)
//        createAndSetupVCurrencyStackView(into: hCurrencyStackView, imageName: "RUB", text: "RUB")
//        createAndSetupVCurrencyStackView(into: hCurrencyStackView2, imageName: "USD", text: "USD")
        
        inLabel.text = "RUB"
        inLabel.textColor = .gray
        inLabel.font = .systemFont(ofSize: 18)
        inLabel.textAlignment = .right
        upperStackView.addArrangedSubview(inLabel)
        
        setupTextField(into: upperStackView)
        
        outLabel.text = "USD"
        outLabel.textColor = .gray
        outLabel.font = .systemFont(ofSize: 18)
        outLabel.textAlignment = .right
        upperStackView.addArrangedSubview(outLabel)
        
        currencyTextField.text = "0"
        currencyTextField.textColor = .white
        currencyTextField.font = .systemFont(ofSize: 50)
        currencyTextField.adjustsFontSizeToFitWidth = true
        currencyTextField.minimumFontSize = 40
        currencyTextField.textAlignment = .right
        upperStackView.addArrangedSubview(currencyTextField)
        
        var hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "C", color: .lightGray, font: "SFPro-Medium", fontSize: 35, titleColor: .black, colorOfTap: .white)
        createAndSetupButton(into: hStackView, withTitle: "􀄬", color: .lightGray, font: "SFPro-Medium", fontSize: 30, titleColor: .black, colorOfTap: .white)
        createAndSetupButton(into: hStackView, withTitle: "􀘾", color: .lightGray, font: "SFPro-Semibold", fontSize: 28, titleColor: .black, colorOfTap: .white)
        createAndSetupButton(into: hStackView, withTitle: "􀅿", color: UIColor(red: 255.0 / 255.0, green: 149 / 255.0, blue: 0 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 30, titleColor: .white, colorOfTap: UIColor(red: 241.0 / 255.0, green: 163 / 255.0, blue: 59 / 255.0, alpha: 1))
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "7", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "8", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "9", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "􀅾", color: UIColor(red: 255.0 / 255.0, green: 149 / 255.0, blue: 0 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 30, titleColor: .white, colorOfTap: UIColor(red: 241.0 / 255.0, green: 163 / 255.0, blue: 59 / 255.0, alpha: 1))
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "4", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "5", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "6", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "􀅽", color: UIColor(red: 255.0 / 255.0, green: 149 / 255.0, blue: 0 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 30, titleColor: .white, colorOfTap: UIColor(red: 241.0 / 255.0, green: 163 / 255.0, blue: 59 / 255.0, alpha: 1))
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupButton(into: hStackView, withTitle: "1", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "2", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "3", color: .darkGray, font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: "􀅼", color: UIColor(red: 255.0 / 255.0, green: 149 / 255.0, blue: 0 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 30, titleColor: .white, colorOfTap: UIColor(red: 241.0 / 255.0, green: 163 / 255.0, blue: 59 / 255.0, alpha: 1))
        
        hStackView = createAndSetupHStackView(into: vStackView)
        createAndSetupDoubleButton(into: hStackView, withTitle: "0", color: UIColor(red: 80.0 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1), font: "SFPro-Regular", fontSize: 40, titleColor: .white, colorOfTap: .lightGray)
        createAndSetupButton(into: hStackView, withTitle: ",", color: UIColor(red: 80.0 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 40, titleColor: .white, colorOfTap: .white)
        createAndSetupButton(into: hStackView, withTitle: "􀆀", color: UIColor(red: 255.0 / 255.0, green: 149 / 255.0, blue: 0 / 255.0, alpha: 1), font: "SFPro-Medium", fontSize: 30, titleColor: .white, colorOfTap: UIColor(red: 241.0 / 255.0, green: 163 / 255.0, blue: 59 / 255.0, alpha: 1))
    }
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - spacing * 5) / 4
    }
    
    func setupTextField(into stackView: UIStackView) {
        textField.text = "0"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 65)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 40
        textField.textAlignment = .right
        stackView.addArrangedSubview(textField)
    }
    
    
//    ФУНКЦИЯ ДЛЯ СОЗДАНИЯ КАРТИНКИ С ФЛАГОМ СТРАНЫ И ПОДПИСЬЮ
//
//    func createAndSetupVCurrencyStackView(into stackView: UIStackView, imageName: String, text: String) {
//        let vCurrencyStackView = UIStackView()
//        let currencyImageView = UIImageView(image: UIImage(named: imageName))
//        let currencyLabel = UILabel()
//        currencyLabel.text = text
//        currencyLabel.font = .systemFont(ofSize: 16)
//        currencyLabel.textAlignment = .center
//        vCurrencyStackView.addArrangedSubview(currencyImageView)
//        vCurrencyStackView.addArrangedSubview(currencyLabel)
//        vCurrencyStackView.axis = .vertical
//        vCurrencyStackView.spacing = 2
//        stackView.addArrangedSubview(vCurrencyStackView)
//        vCurrencyStackView.snp.makeConstraints {
//            $0.width.equalTo(40)
//        }
//        currencyImageView.snp.makeConstraints {
//            $0.height.equalTo(40)
//        }
//    }
    
//    ФУНКЦИЯ ДЛЯ СЛИЯНИЯ ВЕРТИКАЛЬНОГО СТЕКВЬЮ С КАРТИНКОЙ С ТЕКСТФИЛДОМ
//
//    func createAndSetupHCurrencyStackView(into stackView: UIStackView) -> UIStackView {
//        let hCurrencyStackView = UIStackView()
//        hCurrencyStackView.axis = .horizontal
//        hCurrencyStackView.spacing = 16
//        hCurrencyStackView.alignment = .center
//        stackView.addArrangedSubview(hCurrencyStackView)
//        return hCurrencyStackView
//    }
    
    func createAndSetupUpperStackView(stackView: UIStackView) -> UIStackView {
        let upperStackView = UIStackView()
        upperStackView.axis = .vertical
        upperStackView.distribution = .fill
        view.addSubview(upperStackView)
        upperStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(spacing)
            $0.bottom.equalTo(stackView.snp.top).offset(-16)
//            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(spacing)
            $0.height.equalTo(188)
        }
        return upperStackView
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
    
    func createAndSetupButton(into stackView: UIStackView, withTitle title: String, color: UIColor, font: String, fontSize: CGFloat, titleColor: UIColor, colorOfTap: UIColor) {
        let button = createButton(withTitle: title, color: color, font: font, fontSize: fontSize, titleColor: titleColor, colorOfTap: colorOfTap)
        stackView.addArrangedSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(buttonWidth())
        }
    }
    
    func createAndSetupDoubleButton(into stackView: UIStackView, withTitle title: String, color: UIColor, font: String, fontSize: CGFloat, titleColor: UIColor, colorOfTap: UIColor) {
        let doubleButton = UIButton()
        doubleButton.clipsToBounds = true
        let button = createButton(withTitle: title, color: .clear, font: font, fontSize: fontSize, titleColor: titleColor, colorOfTap: colorOfTap)
        button.isUserInteractionEnabled = false
        doubleButton.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(buttonWidth())
            $0.left.top.bottom.equalToSuperview()
        }
        doubleButton.layer.cornerRadius = buttonWidth() / 2
        doubleButton.backgroundColor = color
        doubleButton.addTarget(self, action: #selector(handler), for: .touchUpInside)
        doubleButton.setTitle("0", for: .normal)
        doubleButton.setBackgroundImage(UIImage(color: colorOfTap), for: .highlighted)
        doubleButton.setBackgroundImage(UIImage(color: color), for: .normal)
        doubleButton.setTitleColor(.clear, for: .normal)
        stackView.addArrangedSubview(doubleButton)
    }
    
    func createButton(withTitle title: String, color: UIColor, font: String, fontSize: CGFloat, titleColor: UIColor, colorOfTap: UIColor) -> UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = buttonWidth() / 2
        button.titleLabel?.font = UIFont(name: font, size: fontSize)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(UIImage(color: colorOfTap), for: .highlighted)
        button.setBackgroundImage(UIImage(color: color), for: .normal)
        button.addTarget(self, action: #selector(handler), for: .touchUpInside)
        return button
    }
    
    var operation: Operation = .add
    var firstOperand = ""
    var secondOperand = ""
    
    @objc func handler(sender: UIButton) {
        let value = sender.title(for: .normal)!
        handle(value)
    }
    
    func handle(_ value: String) {
        if "0123456789".contains(value) {
            if value == "0" && secondOperand.isEmpty {
                return
            }
            if secondOperand.count > 10 {
                return
            }
            secondOperand += value
            textField.text = spacingFormat(secondOperand)
            if isRubActive {
                currencyTextField.text = spacingFormat((textField.text!.doubleValue * currency!.rates.USD).stringValue)
            } else {
                currencyTextField.text = spacingFormat((textField.text!.doubleValue / currency!.rates.USD).stringValue)
            }
            
        } else if "􀅿􀅾􀅼􀅽".contains(value) {
            firstOperand = calculate(firstOperand.doubleValue, secondOperand.doubleValue, operation).stringValue
            textField.text = firstOperand
            operation = Operation(rawValue: value)!
            secondOperand = ""
            
        } else if value == "􀆀" {
            firstOperand = calculate(firstOperand.doubleValue, secondOperand.doubleValue, operation).stringValue
            textField.text = firstOperand
            operation = .add
            secondOperand = ""
            if isRubActive {
                currencyTextField.text = spacingFormat((textField.text!.doubleValue * currency!.rates.USD).stringValue)
            } else {
                currencyTextField.text = spacingFormat((textField.text!.doubleValue / currency!.rates.USD).stringValue)
            }
            //currencyTextField.text = (firstOperand.doubleValue * currency!.rates.USD).stringValue
            
        } else if value == "C" {
//            TODO: Make AC
            textField.text = "0"
            currencyTextField.text = "0"
            operation = .add
            firstOperand = ""
            secondOperand = ""
            
        } else if value == "," {
            if !secondOperand.contains(",") {
                if secondOperand.isEmpty {
                    secondOperand = "0"
                }
                secondOperand += value
                textField.text = secondOperand
            }
            
        } else if value == "􀘾" {
            if secondOperand.isEmpty { return }
            
            if firstOperand.isEmpty {
                secondOperand = (secondOperand.doubleValue / 100).stringValue
            } else {
                secondOperand = (firstOperand.doubleValue / 100.0 * secondOperand.doubleValue).stringValue
            }
            textField.text = secondOperand
            
        } else if value == "􀄬" {
            switchField()
        }
        
    }
    
    func calculate(_ first: Double, _ second: Double, _ operation: Operation) -> Double {
        switch operation {
        case .add:
            return first + second
        case .subtract:
            return first - second
        case .multiply:
            return first * second
        case .divide:
            return first / second
        }
    }
    
    func fromRubToUsd() {
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=RUB&symbols=USD")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            if let currency = try? decoder.decode(Currency.self, from: data) {
                self.currency = currency
                print(currency.base, currency.rates.USD)
            }

        }
        
        task.resume()
    }
    
    func spacingFormat(_ unformatted: String) -> String {
        var formatted = ""
        
        unformatted.reversed().enumerated().forEach { item in
            if item.offset % 3 == 0 && item.offset != 0 {
                formatted = String(item.element) + " " + formatted
            } else {
                formatted = String(item.element) + formatted
            }
        }
        return formatted
    }
    
    func switchField() {
        isRubActive.toggle()
        if isRubActive {
            inLabel.text = "RUB"
            outLabel.text = "USD"
            currencyTextField.text = spacingFormat((textField.text!.doubleValue * currency!.rates.USD).stringValue)
        } else {
            inLabel.text = "USD"
            outLabel.text = "RUB"
            currencyTextField.text = spacingFormat((textField.text!.doubleValue / currency!.rates.USD).stringValue)
        }
    }
}

struct Currency: Decodable {
    var rates: Rates
    var base: String
}

struct Rates: Decodable {
    var USD: Double
}

extension String {
    var doubleValue: Double {
        if self.isEmpty || self == "Ошибка"  { return 0 }
        return Double(self.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: ""))!
    }
}

extension Double {
    var stringValue: String {
        if self.isInfinite {
            return "Ошибка"
        } else if floor(self) == self {
            return String(Int(self))
        } else {
            let s = String(format: "%0.2f", self)
            return s.replacingOccurrences(of: ".", with: ",")
        }
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
      }
    }
