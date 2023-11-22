import os
import strconv


type Element = i64 | []Element

fn (self Element) compare(other Element) ?bool {
    println('- Compare $self vs $other')

    return match self {
        i64 {
            match other {
                i64 { 
                    if self == other {
                        return none
                    }

                    self <= other
                }
                []Element {
                    mut new_self := []Element{}
                    new_self << self
                    Element(new_self).compare(other)?
                }
            }
        }
        []Element {
            match other {
                i64 {
                    mut new_other := []Element{}
                    new_other << other
                    Element(self).compare(Element(new_other))?
                }
                []Element {
                    println('  Comparing lists')
                    mut order := false

                    for i, self_e in self {

                        if i >= other.len {
                            println('  Right ran out of input')
                            break
                        }

                        other_e := other[i]

                        order = self_e.compare(other_e)?
                        break
                    }
                
                    order 
                }
            }
        }
    }
}


struct PacketIterator {
    packet string
mut:
    p int
}

fn (mut self PacketIterator) next() ?Element {
    start := self.p
    self.p++

    if self.p >= self.packet.len {
        return none
    }

    mut nest := 0

    for {
        if self.p >= (self.packet.len - 1) { 
            break
        } 

        match self.packet[self.p] {
            `[` {nest++}
            `]` {nest--}
            `,` {if nest==0 {break}}
            else {}
        }   

        self.p++
    }

    raw := self.packet[1+start..self.p]
    if raw == "" {
        return none
    }

    return strconv.parse_int(raw, 10, 0) or {
        mut iter := PacketIterator{packet: raw}
        return iter.collect()
    }
}

fn (mut self PacketIterator) collect() []Element {
    mut out := []Element{}

    for element in self {
        out << element
    }

    return out
}

fn main() {
    
    lines := os.read_lines('data')!
    mut part_one := 0
    mut i := 0

    for (i <= lines.len) {
        println('== Pair ${(i/3) + 1} ==')
        mut p1 := PacketIterator{packet: lines[i]}
        mut p2 := PacketIterator{packet: lines[i+1]}

        for {
            left := p1.next() or {
                println('  Left out of input')
                part_one += (i/3) + 1
                println('  Correct order')
                break
            }

            right := p2.next() or {
                println('  Right out of input')
                println('  Incorrect Order')
                break
            }
          
            result := left.compare(right) or {
                println('  continuing')
                continue
            }

            if result {
                println('  Correct Order')
                part_one += (i/3) + 1
            } else {
                println('  Incorrect Order')
            }

            break
        }
        
        i += 3
    }
    
    println('Part one: $part_one')
}
