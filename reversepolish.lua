local reverse_polish = "3 10 5 + *"

local reverse_polish_table = {}

for v in reverse_polish:gmatch("([^ ]+)")do table.insert(reverse_polish_table, v) end -- loads string into table

-- operators have 1 pair of numbers before it to be executed

local operators = { -- support for custom operators
	["*"] = function(a,b)return a * b end;
	["/"] = function(a,b)return a / b end;
	["+"] = function(a,b)return a + b end;
	["-"] = function(a,b)return a - b end
}

local function is_operator(v)return operators[v]and true or false end 

local function lexer(i) -- returns value and step
	local v = reverse_polish_table[i]

	if is_operator(v)then
		local first_num, first_pos = lexer(i - 1)
		local second_num, next_pos = lexer(first_pos)
		
		if second_num == nil then error("Invalid Input") end

		return operators[v](second_num, first_num), next_pos
	end

	return v, i - 1
end

local pos = #reverse_polish_table
local last_val
while pos ~= 0 do
	local v, p = lexer(pos)
	pos = p
	last_val = v
end

print(last_val)