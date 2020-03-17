import XCTest
@testable import lexer

class LexerInputStreamTest: XCTestCase {
  
  func test_next() {
    let string = "ab"
    let stream = LexerInputStream(string: string)
    
    XCTAssert(stream?.next() == "a")
    XCTAssert(stream?.next() == "b")
  }
  
  func test_retract2() {
    let string = "abc"
    let stream = LexerInputStream(string: string)
    
    XCTAssert(stream?.next() == "a")
    XCTAssert(stream?.next() == "b")
    stream?.retract()
    XCTAssert(stream?.next() == "b")
    stream?.retract()
    stream?.retract()
    XCTAssert(stream?.next() == "a")
    XCTAssert(stream?.next() == "b")
    XCTAssert(stream?.next() == "c")
    
    stream?.retract()
    XCTAssert(stream?.next() == "c")
    
    XCTAssert(stream?.next() == nil)
    stream?.retract()
    stream?.retract()
    XCTAssert(stream?.next() == "c")
  }
  
  static var allTests = [
    ("test_next", test_next),
    ("test_retract2", test_retract2),
  ]
  
}
