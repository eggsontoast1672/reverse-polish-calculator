module Lexer (tokenize, trimStart, trimEnd, trim) where

import qualified Data.Char as Char

trimStart :: String -> String
trimStart = dropWhile Char.isSpace

trimEnd :: String -> String
trimEnd = reverse . trimStart . reverse

trim :: String -> String
trim = trimEnd . trimStart

data Token
  = Minus
  | Plus
  | Slash
  | Star
  | Number Int
  deriving (Show)

parseAfterWhitespace :: String -> Maybe (Token, String)
parseAfterWhitespace = parseToken . trimStart

parseInteger :: String -> Maybe (Token, String)
parseInteger source = case span Char.isDigit source of
  ("", _) -> Nothing
  (number, rest) -> Just (Number $ read number, rest)

parseToken :: String -> Maybe (Token, String)
parseToken "" = Nothing
parseToken source@(first : rest) = case first of
  '-' -> Just (Minus, rest)
  '+' -> Just (Plus, rest)
  '/' -> Just (Slash, rest)
  '*' -> Just (Star, rest)
  _
    | Char.isDigit first -> parseInteger source
    | Char.isSpace first -> parseAfterWhitespace source
    | otherwise -> Nothing

tokenize :: String -> [Token]
tokenize source = go source []
  where
    go src tokens = case parseToken src of
      Just (token, rest) -> token : tokenize rest
      Nothing -> reverse tokens
