
function load_book(book_file)
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

vim.api.nvim_create_user_command("RbsLoadBook",
  function(opts)
    local file = opts.fargs[1]
    load_book(file, from, to, word)
  end,
  { nargs = 1 })

function select_range(from, to)
  local data = {}
  local n = 1
  local in_range = false
  for k,v in pairs(vim.g.rbs_book) do
    if not in_range then
      if v.id == from then
        in_range = true
      end
    end
    if in_range then
      data[n] = v
      n = n + 1
      if v.id == to then
        in_range = false
        break
      end
    end
  end
  vim.g.rbs_range_from = from
  vim.g.rbs_range_to = to
  vim.g.rbs_data = data
end

vim.api.nvim_create_user_command("RbsSelectRange",
  function(opts)
    local from = opts.fargs[1]
    local to = opts.fargs[2]
    select_range(from, to)
  end,
  { nargs = "*" })

function describe_repeated_sn(sn)

  local addresses = {}
  local list = ""
  local count = 0
  local word = 0

  for k,v in pairs(vim.g.rbs_data) do
    if v.sn == sn then
      count = count + 1
      word = v.enlexeme
      if not addresses[v.addr] then
        addresses[v.addr] = true
        if not (list == "") then
          list = list .. ", "
        end
        list = list .. v.addr
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

