//
// Copyright © 2018 Nicola Lancellotti. All rights reserved.
//

import lexer

func makeLexer(text: String) -> Lexer {
  let stream = LexerInputStream(string: text)!
  return Lexer(stream: stream)
}
