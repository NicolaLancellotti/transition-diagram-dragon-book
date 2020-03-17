import XCTest

import lexerTests

var tests = [XCTestCaseEntry]()
tests += lexerTests.allTests()
XCTMain(tests)
