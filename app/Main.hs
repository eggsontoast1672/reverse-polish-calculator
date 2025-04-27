module Main where

import Lexer (tokenize)
import System.IO (hFlush, stdout)

evaluate :: String -> IO ()
evaluate = print . tokenize

getLinePrompt :: String -> IO String
getLinePrompt prompt = do
  putStr prompt
  hFlush stdout
  getLine

runRepl :: IO ()
runRepl = do
  line <- getLinePrompt "> "
  evaluate line
  runRepl

main :: IO ()
main = runRepl
