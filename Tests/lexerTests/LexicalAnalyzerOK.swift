import XCTest
@testable import lexer

class LexicalAnalyzerOK: XCTestCase {
  
  func test_eof() {
    let text = ""
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_white() {
    let text = "\n\t <"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .operator(.lt): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_operators() {
    let text = "<<==<>>>="
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .operator(.lt): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .operator(.le): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .operator(.eq): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .operator(.ne): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .operator(.gt): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .operator(.ge): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_id() {
    let text = "x xx x1"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .id(_): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .id(_): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .id(_): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_key() {
    let text = "if then else while for"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .key(.if): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .key(.then): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .key(.else): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .key(.while): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .key(.for): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_separator() {
    let text = "()[],;"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .separator(.lParen): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .separator(.rParen): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .separator(.lSquare): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .separator(.rSquare): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .separator(.comma): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .separator(.semi): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_nconst() {
    let text = "0 01 11"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .nConst("0"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .nConst("01"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .nConst("11"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  func test_fconst() {
    let text = "0.1 2E1 2E+1 2E-1 0.2E1 0.2E+1 0.2E-1 0.2E-11"
    let lexer = makeLexer(text: text)
    
    switch lexer.nextToken() {
      case .fConst("0.1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("2E1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("2E+1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("2E-1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("0.2E1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("0.2E+1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("0.2E-1"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .fConst("0.2E-11"): break
      default: XCTFail()
    }
    
    switch lexer.nextToken() {
      case .eof: break
      default: XCTFail()
    }
  }
  
  static var allTests = [
    ("test_eof", test_eof),
    ("test_white", test_white),
    ("test_operators", test_operators),
    ("test_id", test_id),
    ("test_key", test_key),
    ("test_separator", test_separator),
    ("test_nconst", test_nconst),
    ("test_fconst", test_fconst),
  ]
  
}
