open Lexer

let evaluate s = print_endline s

let get_line prompt =
  print_string prompt;
  flush stdout;
  In_channel.input_line stdin

let rec run_repl () =
  match get_line "> " with
  | Some s ->
      evaluate s;
      run_repl ()
  | None -> ()

let () = run_repl ()
