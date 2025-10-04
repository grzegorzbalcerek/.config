
function for_lines_between(file,from,to,f)
  local found = 0
  io.input(file)
  for line in io.lines() do
    if found == 0 then
      if string.find(line, "addr=" .. from) then
        found = 1
      end
    end
    if found == 1 then
      f(line)
      if string.find(line, "addr=" .. to) then
        found = 2
      end
    end
  end
  io.input():close()
end

function describe_repeated_words(file, from, to, word)

  local addresses = {}
  local list = ""
  local count = 0

  for_lines_between(file, from, to, function(line)
    if string.find(line, word) then
      count = count + 1
      local found, _, addr = string.find(line, "addr=([^.]*)")
      if found then
        if not addresses[addr] then
          addresses[addr] = true
          if not (list == "") then
            list = list .. ", "
          end
          list = list .. addr
        end
      end
    end
  end)

  local description = "The word “" .. word .. "” is repeated " .. count .. " times (" .. list .. ")."

  nvim_paste(description, true, -1)
end


vim.api.nvim_create_user_command("RbsDescribeRepeatedWords",
  function(opts)
    local file = opts.fargs[1]
    local from = opts.fargs[2]
    local to = opts.fargs[3]
    local word = opts.fargs[4]
    describe_repeated_words(file, from, to, word)
  end,
  { nargs = "+" })

