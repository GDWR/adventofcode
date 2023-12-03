import java.io.File

val input = File("input.txt").readText()
val engineSchematic = EngineSchematic.parse(input)

val partOne = engineSchematic.parts
        .filter { engineSchematic.getSymbolsInRange(it.spanIndex, it.startIndex.y).any() }
        .sumOf { it.number }

println("Part one: $partOne")

val partTwo = engineSchematic.symbols
        .filter { it.char == '*' }
        .map { engineSchematic.getPartsAroundIndex(it.index) }
        .filter { it.size == 2 }
        .sumOf { it[0].number * it[1].number }

println("Part two: $partTwo")


data class Index(val x: Int, val y: Int)

// Technically these are not "Part"s as defined in the problem, but I wanted to capture
//    all the numbers in a single data class.
data class Part(val number: Int, val startIndex: Index) {
    val endIndex: Index
        get() = Index(startIndex.x + number.toString().length - 1, startIndex.y)

    val rowIndex: Int
        get() = startIndex.y

    // Span over y, as a part cannot span over rows
    val spanIndex: IntRange
        get() = startIndex.x..endIndex.x
}

data class Symbol(val char: Char, val index: Index)

data class EngineSchematic(val parts: List<Part>, val symbols: List<Symbol>) {
    companion object {
        fun parse(input: String): EngineSchematic {
            val symbols = mutableListOf<Symbol>()
            val parts = mutableListOf<Part>()

            for ((y, line) in input.lines().withIndex()) {
                var numBuffer = ""

                for ((x, char) in line.withIndex()) {
                    if (char == '.') {
                        if (numBuffer.isNotEmpty()) {
                            val newPart = Part(numBuffer.toInt(), Index(x - numBuffer.length, y))
                            parts.add(newPart)
                            numBuffer = ""
                        }

                        continue
                    } else if (char.isDigit()) {
                        // If we used a while loop, we could forward the parse until we capture
                        //   the entire number. For now, we utilize scoped variables for this state.
                        numBuffer += char
                    } else {
                        val newSymbol = Symbol(char, Index(x, y))
                        symbols.add(newSymbol)

                        if (numBuffer.isNotEmpty()) {
                            val newPart = Part(numBuffer.toInt(), Index(x - numBuffer.length, y))
                            parts.add(newPart)
                            numBuffer = ""
                        }
                    }
                }

                if (numBuffer.isNotEmpty()) {
                    val newPart = Part(numBuffer.toInt(), Index(line.length - numBuffer.length, y))
                    parts.add(newPart)
                }
            }

            return EngineSchematic(parts = parts, symbols = symbols)
        }
    }

    fun getSymbolsInRange(range: IntRange, y: Int): List<Symbol> {
        return symbols
                .filter { symbol -> symbol.index.y in y - 1..y + 1 }
                .filter { symbol -> symbol.index.x in range.first - 1..range.last + 1 }
    }

    fun getPartsAroundIndex(index: Index): List<Part> {
        return parts
            .filter { part -> part.startIndex.y in index.y - 1..index.y + 1 }
            .filter { part -> index.x in part.startIndex.x-1..part.endIndex.x+1 }
    }
}
