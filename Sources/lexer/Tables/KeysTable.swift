import Foundation

public class KeysTable {
  
  public enum Keys: String {
    case `if`
    case then
    case `else`
    case `while`
    case `for`
  }
  
  static func token(for id: String) -> Token? {
    if let key = Keys.init(rawValue: id) {
      return Token.key(key)
    } else {
      return nil
    }
  }
}
