import java.io.File

val input = File("input.txt").readLines()

// Bool mask, for each symbol and its surrounding cells
val mask = Array(input.size) {
    Array(input.first().length) { false }
}.also {
    input.forEachIndexed { i, line ->
        line.forEachIndexed { j, char ->
            if (char != '.' && !char.isDigit()) {
                (-1..1).forEach { iOff ->
                    (-1..1).forEach { jOff ->
                        // this could be out of bounds, but puzzle author was nice
                        it[i + iOff][j + jOff] = true
                    }
                }
            }
        }
    }
}


var partOne = mutableListOf<Int>()

for ((i, row) in input.withIndex()) {
    var numBuffer = ""
    var inRangeOfSymbol = false

    for ((j, char) in row.withIndex()) {
        if (char.isDigit()) {
            if (!inRangeOfSymbol && mask[i][j]) {
                inRangeOfSymbol = true
            }

            numBuffer += char
        } else {
            if (inRangeOfSymbol && numBuffer.isNotEmpty()) {
                partOne.add(numBuffer.toInt())
            }
            numBuffer = ""
            inRangeOfSymbol = false
        }
    }

    if (inRangeOfSymbol && numBuffer.isNotEmpty()) {
        partOne.add(numBuffer.toInt())
    }
}

println("Part one: ${partOne.sum()}")