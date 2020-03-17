import Foundation

import XCTest
@testable import lexer

class LexicalAnalyzerKO: XCTestCase {
  
  func test_error() {
    let text = "|"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .error(.unknown): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .error(.unknown): break
      default: XCTFail()
    }
  }
  
  func test_number_error1() {
    // state 14
    let text = "1."
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .error(.malformedNumber): break
      default: XCTFail()
    }
    
  }
  
  func test_number_error2() {
    // state 16
    let text = "1E"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .error(.malformedNumber): break
      default: XCTFail()
    }
  }
  
  func test_number_error3() {
    // state 17
    let text = "1E+"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .error(.malformedNumber): break
      default: XCTFail()
    }
  }
  
  static var allTests = [
    ("test_error", test_error),
    ("test_number_error1", test_number_error1),
    ("test_number_error2", test_number_error2),
    ("test_number_error3", test_number_error3),
  ]
  
}
