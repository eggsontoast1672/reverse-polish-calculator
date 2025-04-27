import gleeunit
import gleeunit/should

import lexer

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn plus_test() {
  "32 645 +"
  |> lexer.tokenize
  |> should.equal([lexer.Number(32), lexer.Number(645), lexer.Plus])
}
