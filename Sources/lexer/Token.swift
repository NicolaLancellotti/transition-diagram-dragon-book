import Foundation

public enum Token: Equatable {
  
  case error(LexerError)
  case eof
  case `operator`(OperatorAttribute)
  case id(Int)
  case key(KeysTable.Keys)
  case nConst(String)
  case fConst(String)
  case separator(SeparatorAttribute)
  
  public enum OperatorAttribute: String {
    case lt // <
    case le // <=
    case eq // =
    case ne // <>
    case gt // >
    case ge // >=
  }
  
  public enum SeparatorAttribute: Character, CustomStringConvertible  {
    case lParen = "("
    case rParen = ")"
    case lSquare = "["
    case rSquare = "]"
    case comma = ","
    case semi = ";"
    
    public var description: String {
      switch self {
        case .lParen : return "LPAREN"
        case .rParen : return "RPAREN"
        case .lSquare : return "LSQUARE"
        case .rSquare : return "RSQUARE"
        case .comma : return "COMMA"
        case .semi : return "SEMI"
      }
    }
  }
  
  public enum LexerError: String {
    case malformedNumber = "Malformed number"
    case unknown = "Unknown token"
  }
}

extension Token: CustomStringConvertible {
  
  public var description: String {
    switch self {
      case let .operator(attribute): return "〈OP, \(attribute.rawValue.uppercased())〉"
      case let .id(attr): return "〈ID, \(attr)〉"
      case let .key(attr): return "〈KEY, \(attr.rawValue.uppercased())〉"
      case let .nConst(attr): return "〈NCONST, \(attr)〉"
      case let .fConst(attr): return "〈FCONST, \(attr)〉"
      case let .separator(attr): return "〈SEP, \(attr)〉"
      case .eof: return "〈EOF〉"
      case .error(let e): return "Error: \(e.rawValue)"
    }
  }
  
}
