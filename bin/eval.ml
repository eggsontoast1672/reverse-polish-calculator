open Lexer

let eval tokens =
  let rec aux tokens stack =
    let eval_binop func tokens = function
      | right :: left :: rest -> aux tokens (func left right :: rest)
      | _ -> Error ()
    in
    let eval_div tokens stack = Error () in
    match tokens with
    | Minus :: rest -> eval_binop ( - ) rest stack
    | Plus :: rest -> eval_binop ( + ) rest stack
    | Star :: rest -> eval_binop ( * ) rest stack
    | Slash :: rest -> eval_div rest stack
    | Number value :: rest -> aux rest (value :: stack)
    | [] -> ( match stack with [ value ] -> Ok value | _ -> Error ())
  in
  aux tokens []
