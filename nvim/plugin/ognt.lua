
function load_file(file)
    local words = {}
    local concordance = {}
    local nw = 1
    function Word(w)
        words[nw] = w
        nw = nw + 1
    end
    function Concordance(c)
        concordance[c.sn] = c
    end
    dofile(file)
    vim.g.RbsFileWords = words
    vim.g.RbsWords = words
    vim.g.RbsConcordance = concordance
end

vim.api.nvim_create_user_command("RbsLoad",
    function(opts)
        local file = opts.fargs[1]
        load_file(file)
      end,
      { nargs = 1 })

function sn_info(sn)
    return vim.g.RbsConcordance[sn].sn .. " " ..
           vim.g.RbsConcordance[sn].grlexeme .. " " ..
           vim.g.RbsConcordance[sn].enlexeme .. " " ..
           vim.g.RbsConcordance[sn].t1lexeme .. " " ..
           vim.g.RbsConcordance[sn].t2lexeme .. " " ..
           vim.g.RbsConcordance[sn].count
end

vim.api.nvim_create_user_command("RbsSn",
    function(opts)
        local sn = opts.fargs[1]
        print(sn_info(sn))
        print(vim.g.RbsConcordance[sn].addrs)
        print(vim.g.RbsConcordance[sn].verses)
    end,
    { nargs = 1 })

vim.api.nvim_create_user_command("RbsCFind",
    function(opts)
        local str = opts.fargs[1]
        for k,v in pairs(vim.g.RbsConcordance) do
            if string.match(v.sn, str) or string.match(v.enlexeme, str) or string.match(v.t2lexeme, str) then
                print(sn_info(v.sn))
            end
        end
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
    for k,v in pairs(vim.g.RbsWords) do
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
    vim.g.RbsWords = data
    print("Lines " .. tostring(n))
end

vim.api.nvim_create_user_command("RbsRange",
    function(opts)
        local from = opts.fargs[1]
        local to = opts.fargs[2]
        if from and to then
            range(from, to)
        else
            vim.g.RbsWords = vim.g.RbsFileWords
            print("Range unset")
        end
    end,
    { nargs = "*" })

function count_sn(sn)

    local verses = {}
    local list = ""
    local count = 0

    for k,v in pairs(vim.g.RbsWords) do
        if v.sn == sn then
          count = count + 1
          if not verses[v.verse] then
              verses[v.verse] = true
              if not (list == "") then
                  list = list .. ", "
              end
              list = list .. v.verse
          end
        end
    end

    local result = vim.g.RbsConcordance[sn]
    return "The word “" .. enlexeme .. "” (" .. t1lexeme .. ") is repeated " .. count .. " times (" .. list .. ")."
end

function repeated_sn(sn)

    local verses = {}
    local list = ""
    local count = 0
    local enlexeme = ""
    local t1lexeme = ""

    for k,v in pairs(vim.g.RbsWords) do
        if v.sn == sn then
          count = count + 1
          enlexeme = v.enlexeme
          t1lexeme = v.t1lexeme
          if not verses[v.verse] then
              verses[v.verse] = true
              if not (list == "") then
                  list = list .. ", "
              end
              list = list .. v.verse
          end
        end
    end

    return "The word “" .. enlexeme .. "” (" .. t1lexeme .. ") is repeated " .. count .. " times (" .. list .. ")."
end

vim.api.nvim_create_user_command("RbsInsertRepeatedSn",
    function(opts)
        local description = repeated_sn(opts.fargs[1])
        vim.api.nvim_paste(description, true, -1)
    end,
    { nargs = 1 })

vim.api.nvim_create_user_command("RbsPrintRepeatedSn",
    function(opts)
        local description = repeated_sn(opts.fargs[1])
        print(description)
    end,
    { nargs = 1 })

if vim.g.rbs_file then
    load_file(vim.g.rbs_file)
end

