import Foundation

public class Lexer {
  
  public let stringsTable: StringsTable
  private let stream: LexerInputStream
  private var state = 0
  private(set) var afterTheNext: Token = .eof
  
  public init(stream: LexerInputStream) {
    self.stream = stream
    self.stringsTable = StringsTable()
    self.afterTheNext = lexImpl()
  }
  
  public func printTokens<Target: TextOutputStream>(to output: inout Target) {
  loop: while true {
    let token = nextToken()
    print(token, separator: "", terminator: "\n", to: &output)
    switch token {
      case .eof, .error(_): break loop
      default: break
    }
  }
  }
  
  public func nextToken() -> Token {
    let result = afterTheNext
    
    switch result {
      case .eof, .error(_): break
      default: afterTheNext = lexImpl()
    }
    return result
  }
  
  func lexImpl() -> Token {
    state = 0
    
    var lexeme = ""
    
    while true {
      switch state {
          // MARK: - Operators
        case 0:
          switch stream.next() {
            case "<": state = 1
            case "=": state = 5
            case ">": state = 6
            default: stream.retract(); state = 9
          }
        case 1:
          switch stream.next() {
            case "=": state = 2
            case ">": state = 3
            default: state = 4
          }
        case 2: return .operator(.le)
        case 3: return .operator(.ne)
        case 4:
          stream.retract()
          return .operator(.lt)
        case 5: return .operator(.eq)
        case 6:
          switch stream.next() {
            case "=": state = 7
            default: state = 8
          }
        case 7: return .operator(.ge)
        case 8:
          stream.retract()
          return .operator(.gt)
          // MARK: - IDs & Keys
        case 9:
          switch stream.next() {
            case .some(let c) where c.isAlpha:
              state = 10
              lexeme.append(c)
            default: stream.retract(); state = 12
          }
        case 10:
          switch stream.next() {
            case .some(let c) where c.isNumber || c.isAlpha:
              lexeme.append(c)
            default: state = 11
          }
        case 11:
          stream.retract()
          switch KeysTable.token(for: lexeme) {
            case .some(let token): return token
            case .none: return Token.id(stringsTable.put(lexeme))
          }
          // MARK: - Numbers
        case 12:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 13
            default: stream.retract(); state = 22
          }
        case 13:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 13
            case .some("."):
              lexeme.append(".")
              state = 14
            case .some("E"):
              lexeme.append("E")
              state = 16
            default:
              state = 20
          }
        case 14:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 15
            default: return .error(.malformedNumber)
          }
        case 15:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 15
            case .some("E"):
              lexeme.append("E")
              state = 16
            default: state = 21
          }
        case 16:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 18
            case .some("+"):
              lexeme.append("+")
              state = 17
            case .some("-"):
              lexeme.append("-")
              state = 17
            default:
              return .error(.malformedNumber)
          }
        case 17:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 18
            default: return .error(.malformedNumber)
          }
        case 18:
          switch stream.next() {
            case .some(let c) where c.isNumber:
              lexeme.append(c)
              state = 18
            default:
              state = 19
          }
        case 19: stream.retract(); return .fConst(lexeme)
        case 20: stream.retract(); return .nConst(lexeme)
        case 21: stream.retract(); return .fConst(lexeme)
          // MARK: - Blanks
        case 22:
          switch stream.next() {
            case .some(let c) where c.isBlank:
              state = 23
            case .none: return .eof
            default: stream.retract(); state = 25
          }
        case 23:
          switch stream.next() {
            case .some(let c) where c.isBlank: state = 23
            default: state = 24
          }
        case 24:
          stream.retract()
          return lexImpl()
          // MARK: - Separators
        case 25:
          if let x = stream.next().flatMap({Token.SeparatorAttribute(rawValue: $0)}) {
            return .separator(x)
          } else {
            stream.retract(); return .error(.unknown)
          }
          // MARK: - Errors
        default: unreachable()
      }
    }
  }
  
}
