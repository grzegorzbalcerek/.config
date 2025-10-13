
function load_book(book_file)
    local book = {}
    local n = 1
    function Word(w)
        book[n] = w
        n = n + 1
    end
    dofile(book_file)
    vim.g.RbsBook = book
    vim.g.RbsData = book
end

vim.api.nvim_create_user_command("RbsLoadBook",
    function(opts)
        local file = opts.fargs[1]
        book(file)
      end,
      { nargs = 1 })

function range(from, to)
    local data = {}
    local n = 1
    local field_from = "verse"
    if string.match(from, "[.]") then
        field_from = "addr"
    end
    local field_to = "verse"
    if string.match(to, "[.]") then
        field_to = "addr"
    end
    local phase = 1 -- 1: before the first verse, 2: in range, 3: in the last verse
    for k,v in pairs(vim.g.RbsBook) do
        if phase == 1 then
            if v[field_from] == from then
                phase = 2
            end
        end
        if phase == 2 or phase == 3 then
            data[n] = v
            n = n + 1
        end
        if phase == 2 and v[field_to] == to then
            phase = 3
        end
        if phase == 3 and v[field_to] ~= to then
            break
        end
    end
    vim.g.RbsData = data
    print("Lines " .. tostring(n))
end

vim.api.nvim_create_user_command("RbsRange",
    function(opts)
        local from = opts.fargs[1]
        local to = opts.fargs[2]
        if from and to then
            range(from, to)
        else
            vim.g.RbsData = vim.g.RbsBook
            print("Range unset")
        end
    end,
    { nargs = "*" })

function describe_repeated_sn(sn)

    local verses = {}
    local list = ""
    local count = 0
    local word = 0

    for k,v in pairs(vim.g.RbsData) do
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

if vim.g.RbsBookFile then
    load_book(vim.g.RbsBookFile)
end

