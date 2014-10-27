import Text.Parsec
import Text.Parsec.String (Parser)


number :: Parser Float
number = fmap readFloat numberString
  where readFloat = read :: String -> Float
        numberString :: Parser String
        numberString = many1 digit
