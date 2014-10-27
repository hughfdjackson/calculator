import Prelude hiding (subtract)
import Text.Parsec
import Text.Parsec.String (Parser)


number :: Parser Float
number = withWhitespace plainNumber
  where plainNumber = fmap readFloat numberString
        readFloat = read :: String -> Float
        numberString = many1 digit
        withWhitespace parser = between spaces spaces parser 

plus :: Parser (Float -> Float -> Float)
plus = fmap (const add) plusChar
  where add a b = a + b
        plusChar = char '+'

subtract :: Parser (Float -> Float -> Float)
subtract = fmap (const subtract) subtractChar
  where subtract a b = a - b
        subtractChar = char '-'


divide :: Parser (Float -> Float -> Float)
divide = fmap (const divide) divideChar
  where divide a b = a / b
        divideChar = char '/'

multiply :: Parser (Float -> Float -> Float)
multiply = fmap (const multiply) multiplyChar
  where multiply a b = a * b
        multiplyChar = char '*'

chainMultiplyDivide :: Parser Float
chainMultiplyDivide = chainl1 number (divide <|> multiply) 

expression :: Parser Float
expression = chainl1 chainMultiplyDivide (plus <|> subtract) 

