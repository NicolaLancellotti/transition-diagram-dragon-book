//
// Copyright © 2018 Nicola Lancellotti. All rights reserved.
//

import Foundation

class StandardOutputStream: TextOutputStream {
   func write(_ string: String) {
    string.data(using: .utf8).map { data in
      FileHandle.standardOutput.write(data)
    }
  }
}

var standardOutput = StandardOutputStream()
