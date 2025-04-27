import gleam/bool
import gleam/list
import gleam/order
import gleam/result
import gleam/string

pub type Token {
  Minus
  Plus
  Slash
  Star
  Number(Int)
}

pub fn tokenize(source: String) -> List(Token) {
  let go = fn(source, tokens) {
    case get_next_token(source) {
      Ok(#(token, rest)) -> [token, ..tokenize(rest)]
      Error(Nil) -> list.reverse(tokens)
    }
  }
  go(source, [])
}

const ascii_zero = 48

const ascii_nine = 57

fn is_ascii_integer(s: String) -> Bool {
  string.to_graphemes(s)
  |> list.all(fn(c) { string.compare(c, "0") == order.Gt })
}

fn is_ascii_space(_s: String) -> Bool {
  todo
}

fn parse_integer(source: String) -> Result(#(Token, String), Nil) {
  todo
}

fn parse_after_whitespace(source: String) -> Result(#(Token, String), Nil) {
  todo
}

fn get_next_token(source: String) -> Result(#(Token, String), Nil) {
  use #(first, rest) <- result.try(string.pop_grapheme(source))
  case first {
    "-" -> Ok(#(Minus, rest))
    "+" -> Ok(#(Plus, rest))
    "/" -> Ok(#(Slash, rest))
    "*" -> Ok(#(Star, rest))
    other -> {
      use <- bool.guard(is_ascii_integer(other), parse_integer(source))
      use <- bool.guard(is_ascii_space(other), parse_after_whitespace(source))
      Error(Nil)
    }
  }
}
