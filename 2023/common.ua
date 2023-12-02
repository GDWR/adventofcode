Input ← &ru"\0"&fo"input.txt"

Split ← ⊜□≠,
---
⍤"Split \"Hello World\" on \" \" failed" ≍ [□"Hello" □"World"] Split@ "Hello World"
⍤"Split \"[1 2 3 4 5]\" on 4 failed" ≍ [□[1 2 3] □[5]] Split4[1 2 3 4 5]
---
