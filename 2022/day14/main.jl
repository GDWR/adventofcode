#=
main:
- Julia version: 
- Author: GDWR
- Date: 2022-12-19
=#

MIN_X, MAX_X = Inf, -Inf
MIN_Y, MAX_Y = 0, -Inf

function parse_data(fp) Array{Array{Tuple{Int,Int}}}
    paths = []

    open(fp, "r") do f
    for l in readlines(f)
        new_line::Array{Tuple{Int,Int}} = []
        for p in split(l, "->")
            parse_int(v) = parse(Int, v)
            x, y = map(parse_int, split(p, ','))

            global MIN_X, MAX_X
            if x > MAX_X
                MAX_X = x
            elseif x < MIN_X
                MIN_X = x
            end

            global MIN_Y, MAX_Y
            if y > MAX_Y
                MAX_Y = y
            elseif y < MIN_Y
                MIN_Y = y
            end
            push!(new_line, (x, y))
        end
        push!(paths, new_line)
    end
end

    return paths
end


function print_world(world)
    for row in eachrow(world)
        for element in row
            if element == 0
                print('.')
            elseif element == 1
                print('#')
            elseif element == 2
                print('o')
            elseif element == 3
                print('+')
            end
        end
        print('\n')
    end
end

paths = parse_data("data")
println("X = (min=$MIN_X, max=$MAX_X)")
println("Y = (min=$MIN_Y, max=$MAX_Y)")

MIN_X -= 1
MAX_X += 1

SAND_SPAWNER_POS = (1, 1 + (500 - MIN_X))
world = zeros(Int, (MAX_Y - MIN_Y) + 1, (MAX_X - MIN_X) + 1)
world[SAND_SPAWNER_POS[1], SAND_SPAWNER_POS[2]] = 3

for path in paths
    for ((fx, fy), (sx, sy)) in zip(path, path[2:end])
        if fx != sx
            for i in range(start = fx, stop = sx, step = sign(sx - fx))
                world[1 + fy, 1 + (i - MIN_X)] = 1
            end
        else
            for i in range(start = fy, stop = sy, step = sign(sy - fy))
                world[1 + i, 1 + (fx - MIN_X)] = 1
            end
        end
    end
end

print_world(world)

sand_counter = 0
while true
    global sand_counter
    sand_counter += 1
    sand_pos = SAND_SPAWNER_POS
#     println("Sand: $sand_pos")

    while true

        next_pos = try world[sand_pos[1] + 1, sand_pos[2]]
        catch e
            print_world(world)
            println("Falling forever at $(sand_counter-1)")
            exit()
        end

#         println("  Checking $(sand_pos[1] + 1),$(sand_pos[2])")
        if next_pos == 0
#             println("  Hit nothing")
            sand_pos = (sand_pos[1] + 1, sand_pos[2])
        elseif next_pos == 1
#             println("  Hit rock")

            # Try left, then right
            if world[sand_pos[1] + 1, sand_pos[2] - 1] == 0
                sand_pos = (sand_pos[1] + 1, sand_pos[2] - 1)
            elseif world[sand_pos[1] + 1, sand_pos[2] + 1] == 0
                sand_pos = (sand_pos[1] + 1, sand_pos[2] + 1)
            else
                world[sand_pos[1], sand_pos[2]] = 2
                break
            end
        elseif next_pos == 2
#             println("  Hit sand")

            # Try left, then right
            if world[sand_pos[1] + 1, sand_pos[2] - 1] == 0
                sand_pos = (sand_pos[1] + 1, sand_pos[2] - 1)
            elseif world[sand_pos[1] + 1, sand_pos[2] + 1] == 0
                sand_pos = (sand_pos[1] + 1, sand_pos[2] + 1)
            else
                world[sand_pos[1], sand_pos[2]] = 2
                break
            end
        end
    end
end

print_world(world)
