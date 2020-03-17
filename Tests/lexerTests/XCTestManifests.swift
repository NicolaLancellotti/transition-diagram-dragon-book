import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(transition_diagram_dragon_bookTests.allTests),
  ]
}
#endif
