import gleam/int
import gleam/list

import lexer.{type Token}

pub type EvalError {
  DivideByZero
  SyntaxError
}

pub fn evaluate(tokens: List(Token)) -> Result(Int, EvalError) {
  State(tokens, []) |> eval_state
}

type State {
  State(tokens: List(Token), stack: List(Int))
}

fn eval_state(state: State) -> Result(Int, EvalError) {
  case state.tokens {
    [lexer.Minus, ..rest] -> eval_binop(int.subtract, State(rest, state.stack))
    [lexer.Plus, ..rest] -> eval_binop(int.add, State(rest, state.stack))
    [lexer.Star, ..rest] -> eval_binop(int.multiply, State(rest, state.stack))
    [lexer.Slash, ..rest] -> eval_div(State(rest, state.stack))
    [lexer.Number(x), ..rest] -> eval_state(State(rest, [x, ..state.stack]))
    [] -> {
      case list.first(state.stack) {
        Ok(value) -> Ok(value)
        Error(Nil) -> panic
      }
    }
  }
}

type BinOp =
  fn(Int, Int) -> Int

fn eval_binop(op: BinOp, state: State) -> Result(Int, EvalError) {
  case state.stack {
    [right, left, ..rest] ->
      State(state.tokens, [op(left, right), ..rest]) |> eval_state
    _ -> Error(SyntaxError)
  }
}

fn eval_div(state: State) -> Result(Int, EvalError) {
  case state.stack {
    [right, left, ..rest] -> {
      case int.divide(left, right) {
        Ok(quotient) -> State(..state, stack: [quotient, ..rest]) |> eval_state
        Error(Nil) -> Error(DivideByZero)
      }
    }
    _ -> Error(SyntaxError)
  }
}
