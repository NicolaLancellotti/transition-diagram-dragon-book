import Foundation

extension Character {
  
  var isAlpha: Bool {
    return ("A"..."Z").contains(self) || ("a"..."z").contains(self)
  }
  
  var isNumber: Bool {
    return ("0"..."9").contains(self)
  }
  
  var isBlank: Bool {
    return [" ", "\n", "\t"].contains(self)
  }
  
}
