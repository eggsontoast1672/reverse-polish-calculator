import gleam/erlang
import gleam/io
import gleam/string

fn evaluate(source: String) {
  string.trim(source) |> io.println
}

fn run_repl() {
  case erlang.get_line("> ") {
    Ok(line) -> {
      evaluate(line)
      run_repl()
    }
    Error(erlang.Eof) -> Nil
    Error(erlang.NoData) -> {
      io.println("An IO error occurred, please try again.")
      run_repl()
    }
  }
}

pub fn main() {
  run_repl()
}
