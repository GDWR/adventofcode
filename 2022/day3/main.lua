function split_string_in_half(s)
    local line_length = string.len(s)
    local left = string.sub(s, 0, line_length / 2)
    local right = string.sub(s, 1 + (line_length / 2), line_length)

    return left, right
end

function get_common_elements(a, b)
    local output = ""

    -- iter chars of string a
    for i = 1, #a do
        a_char = a:sub(i, i)

        -- iter chars of string b
        for j = 1, #b do
            b_char = b:sub(j, j)

            -- If chars match
            if a_char == b_char then
                -- If char not in output
                if not string.find(output, a_char) then
                    output = output .. a_char
                end
            end
        end
    end

    return output
end

function get_common_elements_three(a, b, c)
    c1 = get_common_elements(a, b)
    c2 = get_common_elements(a, c)
    return get_common_elements(c1, c2)
end

function char_to_score(c)
    local alpha_value = string.byte(string.lower(c)) - 96

    if c == string.upper(c) then
        return alpha_value + 26
    else
        return alpha_value
    end
end

function get_groups()
    local data = io.open("data", "r")

    return function()
        return data:read(), data:read(), data:read()
    end
end

-- Main - Part 1

score = 0
for line in io.lines("data") do
    left, right = split_string_in_half(line)
    common_elements = get_common_elements(left, right)

    -- Iterate char in string
    for i = 1, #common_elements do
        local char = common_elements:sub(i, i)
        score = score + char_to_score(char)
    end
end

print("Part one:", score)

-- Main - Part 2

score = 0
for one, two, three in get_groups() do
    common_elements = get_common_elements_three(one, two, three)
    first_char = common_elements:sub(1, 1)
    score = score + char_to_score(first_char)
end

print("Part two:", score)