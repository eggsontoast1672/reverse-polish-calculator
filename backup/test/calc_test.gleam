import gleam/option.{Some}

import gleeunit
import gleeunit/should

import calc
import lexer

pub fn main() {
  gleeunit.main()
}

pub fn addition_test() {
  [lexer.Number(40), lexer.Number(29), lexer.Plus]
  |> calc.evaluate
  |> should.equal(Ok(69))
}

pub fn subtraction_test() {
  [lexer.Number(234), lexer.Number(165), lexer.Minus]
  |> calc.evaluate
  |> should.equal(Ok(69))
}

pub fn multiplication_test() {
  [lexer.Number(23), lexer.Number(3), lexer.Star]
  |> calc.evaluate
  |> should.equal(Ok(69))
}

pub fn division_test() {
  [lexer.Number(139), lexer.Number(2), lexer.Slash]
  |> calc.evaluate
  |> should.equal(Ok(69))
}
