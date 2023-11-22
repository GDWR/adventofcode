import scala.io.Source
import scala.util.control.Breaks.{break, breakable}



def possiblePath(map: Array[Array[Int]], current: (Int, Int), goal: (Int, Int), path: Array[Array[Boolean]]): List[Array[Array[Boolean]]] = {
  path(current._1)(current._2) = true

  if (current == goal) {
    return List(path)
  }

  var currentVal = map(current._1)(current._2)
  if (currentVal == 'S') {
    currentVal = 'a'
  }

  var paths = List(path)

  for ((x, y) <- List((-1, 0), (0, -1), (1, 0), (0, 1))) {
    breakable {
      val nextX = current._2 + x
      val nextY = current._1 + y

      if (nextX < 0 | nextY < 0 | nextY >= 41 | nextX >= 61) break
      if (path(nextY)(nextX)) break // Already traversed.

      var nextVal = map(nextY)(nextX)
      if (nextVal == 'E') {
        nextVal = 'z'
      }

      if (math.abs(currentVal - nextVal) > 1) break // Too large

      if (currentVal <= nextVal) {
        val newPath: Array[Array[Boolean]] = path.map(_.clone)
        paths = paths.appendedAll(possiblePath(map, (nextY, nextX), goal, newPath))
      }
    }
  }

  paths
}

@main
def main(): Unit = {
  val source = Source.fromFile("data")
  val heightMap = Array.ofDim[Int](41, 61)
  var start = (0, 0)
  var end = (0, 0)

  for ((line, y) <- source.getLines().zipWithIndex) {
    for ((char, x) <- line.zipWithIndex) {

      if (char == 'S') {
        start = (y, x)
      } else if (char == 'E') {
        end = (y, x)
      }

      heightMap(y)(x) = char
    }
  }

  source.close()

  // Print map
  for (row <- heightMap) {
    for (element <- row) {
      print(f" $element%4s ")
    }
    print("\n")
  }

  println(f"\n Moving from $start to $end")
  val v = heightMap(end._1)(end._2)
  println(f"\n Moving from ${v}")

  val partOne = possiblePath(heightMap, start, end, Array.ofDim[Boolean](41, 61))
    .filter(_(end._1)(end._2))
    .map(p => {
      var total: Int = 0
      for (row <- p) {
        for (element <- row) {
          if (element) total += 1
        }
      }

      total
    })
    .sorted

  println(s"Part one: ${partOne.head - 1}")
}