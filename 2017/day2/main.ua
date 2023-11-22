Common ← &i "../common.ua"
  Input ← Common "Input"
  ¦ ← Common "Split"

∵(parse⊔) ≡(¦@\t⊔)¦@\n Input
&p ⊂"Part 1: " ⍘parse/+⌵-≡(/↥⊔)∶≡(/↧⊔).
