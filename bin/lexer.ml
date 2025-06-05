type token = Minus | Plus | Slash | Star | Number of int | EOI
type lexer = { source : string; position : int; ch : char option }

let new_lexer source =
  let ch = try Some source.[0] with Invalid_argument _ -> None in
  { source; position = 0; ch }

let advance lexer =
  let ch =
    try Some lexer.source.[lexer.position + 1] with Invalid_argument _ -> None
  in
  { source = lexer.source; position = lexer.position + 1; ch }

let next_token lexer =
  match lexer.ch with
  | Some '-' -> (Minus, advance lexer)
  | Some '+' -> (Plus, advance lexer)
  | Some '/' -> (Slash, advance lexer)
  | Some '*' -> (Star, advance lexer)

let parse_token input = if String.length input = 0 then None else Some 0
