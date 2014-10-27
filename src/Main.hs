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

chainPlusSubtract :: Parser Float
chainPlusSubtract = chainl1 number (plus <|> subtract) 
