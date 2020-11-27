//
//  CurrencyCalculatorTests.swift
//  CurrencyCalculatorTests
//
//  Created by Olya Ganeva on 04.11.2020.
//

import XCTest
@testable import CurrencyCalculator

class CurrencyCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        let vc = ViewController()
        
        let result = vc.calculate("1", "1", "+")
        
        XCTAssertEqual(result, "2")
    }
    
    func testHandle() {
        let vc = ViewController()
        
        vc.handle("1")
        
        XCTAssertEqual(vc.textField.text, "1")
        
        vc.handle("+")
        
        XCTAssertEqual(vc.textField.text, "1")
        
        vc.handle("2")
        
        XCTAssertEqual(vc.textField.text, "2")
        
        vc.handle("=")
        
        XCTAssertEqual(vc.textField.text, "3")
    }
}
