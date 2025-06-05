module Eval where

import Lexer (Token (..))

data EvalError = DivideByZero | SyntaxError

type Stack = [Int]

data Evaluator = Evaluator [Token] Stack

evaluate :: [Token] -> Either EvalError Int
evaluate tokens = evaluateState $ Evaluator tokens []

evaluateState :: Evaluator -> Either EvalError Int
evaluateState (Evaluator tokens stack) = case tokens of
  (Minus : rest) -> evaluateBinary (-) (Evaluator rest stack)
  (Plus : rest) -> evaluateBinary (+) (Evaluator rest stack)

evaluateBinary :: (Int -> Int -> Int) -> Evaluator -> Either EvalError Int
evaluateBinary _operation (Evaluator _ _) = undefined
