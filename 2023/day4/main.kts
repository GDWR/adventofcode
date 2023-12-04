import java.io.File
import kotlin.math.*

val input = File("input.txt").readLines()
val cards = input.map { Scratchcard.parse(it) }

val partOne = cards.sumOf { floor(2.0.pow(it.wins.size-1.0)) }.toInt()
println("Part one: $partOne")



data class Scratchcard(val numbers: List<Int>, val winningNumbers: List<Int>) {
    companion object {
        fun parse(input: String): Scratchcard {
            val (winningNumbersRaw, numbersRaw) = input.split(':').last().split('|').map { it.trim() }
            val numbers = numbersRaw.split("\\s+".toRegex()).map { it.toInt() }
            val winningNumbers = winningNumbersRaw.split("\\s+".toRegex()).map { it.toInt() }

            return Scratchcard(numbers, winningNumbers)
        }
    }

    val wins: List<Int>
        get() = numbers.filter { it in winningNumbers }
}
