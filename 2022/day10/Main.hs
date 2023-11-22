module Main where

import Data.Char
import Data.List
import System.IO
import Debug.Trace

data Instr = NoOp
           | AddX Int
           deriving Show


-- (XRegister, Cycle, SignalStrength)
type Env = (Int, Int, Int)


evalInstrs :: Env -> [Instr] -> Env
evalInstrs env instrs = foldl evalInstr env instrs

evalInstr :: Env -> Instr -> Env
evalInstr (reg, cyc, sig) (NoOp)
  | mod (cyc - 20) 40 == 0 = (reg, cyc + 1, sig + (reg * cyc))
  | otherwise              = (reg, cyc + 1, sig)

evalInstr (reg, cyc, sig) (AddX number)
  | mod (cyc - 20)     40 == 0 = (reg + number, cyc + 2, sig + (reg * cyc))
  | mod ((cyc+1) - 20) 40 == 0 = (reg + number, cyc + 2, sig + (reg * (cyc+1)))
  | otherwise                  = (reg + number, cyc + 2, sig) 


parseLines :: String -> [Instr]
parseLines s = map parseLine (lines s)

parseLine :: String -> Instr 
parseLine s | s == "noop"          = NoOp
            | (take 4 s) == "addx" = AddX (read (drop 4 s) :: Int)
            | otherwise            = NoOp


main :: IO ()
main = do
  contents <- getContents
  print (evalInstrs (1, 1, 0) (parseLines contents))
 
