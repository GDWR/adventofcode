Common ← &i "../common.ua"
  Input ← Common "Input"
  Split ← Common "Split"

&p "Part One" /+≡parse∵(⊂:⊔⊢⇌:⊔⊢.regex"\\d"⊔)Split@\n Input
