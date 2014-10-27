import Text.Parsec
import Text.Parsec.String (Parser)


number :: Parser Float
number = withWhitespace plainNumber
  where plainNumber = fmap readFloat numberString
        readFloat = read :: String -> Float
        numberString :: Parser String
        numberString = many1 digit

plus :: Parser (Float -> Float -> Float)
plus = fmap (const add) plusChar
  where add a b = a + b
        plusChar = char '+'

chainPlus :: Parser Float
chainPlus = chainl1 number plus

withWhitespace :: Parser a -> Parser a
withWhitespace parser = between spaces spaces parser 
