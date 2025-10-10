
function book(book_file)
  local book = {}
  local n = 1
  function Word(w)
    book[n] = w
    n = n + 1
  end
  dofile(book_file)
  vim.g.rbs_book = book
  vim.g.rbs_data = book
end

vim.api.nvim_create_user_command("RbsBook",
  function(opts)
    local file = opts.fargs[1]
    book(file)
  end,
  { nargs = 1 })

-- select range using the addr field
function range_addr(from, to)
  local data = {}
  local n = 1
  local in_range = false
  for k,v in pairs(vim.g.rbs_book) do
    if not in_range then
      if v.addr == from then
        in_range = true
      end
    end
    if in_range then
      data[n] = v
      n = n + 1
      if v.addr == to then
        in_range = false
        break
      end
    end
  end
  vim.g.rbs_range_addr_from = from
  vim.g.rbs_range_addr_to = to
  vim.g.rbs_range_verse_from = nil
  vim.g.rbs_range_verse_to = nil
  vim.g.rbs_data = data
end

vim.api.nvim_create_user_command("RbsRangeAddr",
  function(opts)
    local from = opts.fargs[1]
    local to = opts.fargs[2]
    range_addr(from, to)
  end,
  { nargs = "*" })

vim.api.nvim_create_user_command("RbsBookRangeAddr",
  function(opts)
    local file = opts.fargs[1]
    local from = opts.fargs[2]
    local to = opts.fargs[3]
    book(file)
    range_addr(from, to)
  end,
  { nargs = "*" })
 
-- select range using the verse field
function range_verse(from, to)
  local data = {}
  local n = 1
  local phase = 1 -- 1: before the first verse 2: in range 3: in the last verse
  for k,v in pairs(vim.g.rbs_book) do
    if phase == 1 then
      if v.verse == from then
        phase = 2
      end
    end
    if phase == 2 or phase == 3 then
      data[n] = v
      n = n + 1
    end
    if phase == 2 and v.verse == to then
      phase = 3
    end
    if phase == 3 and v.verse ~= to then
      break
    end
  end
  vim.g.rbs_range_addr_from = nil
  vim.g.rbs_range_addr_to = nil
  vim.g.rbs_range_verse_from = from
  vim.g.rbs_range_verse_to = to
  vim.g.rbs_data = data
end

vim.api.nvim_create_user_command("RbsRangeVerse",
  function(opts)
    local from = opts.fargs[1]
    local to = opts.fargs[2]
    range_verse(from, to)
  end,
  { nargs = "*" })

vim.api.nvim_create_user_command("RbsBookRangeVerse",
  function(opts)
    local file = opts.fargs[1]
    local from = opts.fargs[2]
    local to = opts.fargs[3]
    book(file)
    range_verse(from, to)
  end,
  { nargs = "*" })

function describe_repeated_sn(sn)

  local verses = {}
  local list = ""
  local count = 0
  local word = 0

  for k,v in pairs(vim.g.rbs_data) do
    if v.sn == sn then
      count = count + 1
      word = v.enlexeme
      if not verses[v.verse] then
        verses[v.verse] = true
        if not (list == "") then
          list = list .. ", "
        end
        list = list .. v.verse
      end
    end
  end

  local description = "The word “" .. word .. "” is repeated " .. count .. " times (" .. list .. ")."

  vim.api.nvim_paste(description, true, -1)
end


vim.api.nvim_create_user_command("RbsDescribeRepeatedSn",
  function(opts)
    describe_repeated_sn(opts.fargs[1])
  end,
  { nargs = 1 })

