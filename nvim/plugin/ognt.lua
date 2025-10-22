
function load_book(book)
    if book then
        vim.g.OgntBook = book
    elseif not vim.g.OgntBook then
        error("Book number not given. Set vim.g.OgntBook or provide the book number as argument")
    end
    local file
    if vim.g.OgntPath then
        file = vim.g.OgntPath .. "/book" .. tostring(vim.g.OgntBook) .. ".lua"
    else
        file = "book" .. tostring(vim.g.OgntBook) .. ".lua"
    end
    local words = {}
    local concordance = {}
    local word_count = 0
    local concordance_count = 0
    function Word(w)
        word_count = word_count + 1
        words[word_count] = w
    end
    function Concordance(c)
        concordance_count = concordance_count + 1
        concordance[c.sn] = c
    end
    dofile(file)
    vim.g.OgntBookWords = words
    vim.g.OgntRangeWords = words
    vim.g.OgntBookConcordance = concordance
    return "Loaded " .. tostring(word_count) .. " words and " .. tostring(concordance_count) .. " concordance entries from file " .. file .. "."
end

vim.api.nvim_create_user_command("OgntLoadBook", function(opts) print(load_book(opts.fargs[1])) end, { nargs = "?" })

function concordance_info(entry)
    return entry.sn .. " " ..
           entry.grlexeme .. " " ..
           entry.t1lexeme .. " " ..
           entry.t2lexeme .. " " ..
           entry.enlexeme .. " " ..
           entry.count .. " " ..
           entry.addrs
end

function concordance_sn(sn)
    local entry = vim.g.OgntBookConcordance[sn]
    if entry then
        print(concordance_info(entry))
    else
        error("Strong number " .. sn .. " entry not found")
    end
end

vim.api.nvim_create_user_command("ConcordanceSn", function(opts) concordance_sn(opts.fargs[1]) end, { nargs = 1 })

function _concordance_matches_str(entry, str)
    return entry.sn == str or string.match(entry.enlexeme, str) or string.match(entry.t2lexeme, str)
end

function concordance_find(str)
    for _,entry in pairs(vim.g.OgntBookConcordance) do
        if _concordance_matches_str(entry, str) then
            print(concordance_info(entry))
        end
    end
end

vim.api.nvim_create_user_command("ConcordanceFind", function(opts) concordance_find(opts.fargs[1]) end, { nargs = 1 })

function range_words(from, to)
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
    for k,v in pairs(vim.g.OgntBookWords) do
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
    vim.g.OgntRangeWords = data
    print("Lines " .. tostring(n))
end

function range(from, to)
    if from and to then
        range_words(from, to)
    else
        vim.g.OgntRangeWords = vim.g.OgntBookWords
        print("Range unset")
    end
end

vim.api.nvim_create_user_command("Range", function(opts) range(opts.fargs[1], opts.fargs[2]) end, { nargs = "*" })

function word_info(entry)

    return entry.addr .. " " ..
           entry.gr .. " " ..
           entry.t1 .. " " ..
           entry.t2 .. " " ..
           entry.en .. " " ..
           entry.sn .. " " ..
           entry.grlexeme .. " " ..
           entry.t1lexeme .. " " ..
           entry.t2lexeme .. " " ..
           entry.enlexeme
end

function _entry_matches_str(entry, str)
    return entry.sn == str or
        string.match(entry.en, str) or
        string.match(entry.enlexeme, str) or
        string.match(entry.t2, str) or
        string.match(entry.t2lexeme, str)
end

function range_find(str)
    for _,entry in pairs(vim.g.OgntRangeWords) do
        if _entry_matches_str(entry, str) then
            print(word_info(v))
        end
    end
end

vim.api.nvim_create_user_command("RangeFind", function(opts) range_find(opts.fargs[1]) end, { nargs = 1 })

function range_count_sn(sn)

    local verses = {}
    local list = ""
    local count = 0

    for k,v in pairs(vim.g.OgntRangeWords) do
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

    local entry = vim.g.OgntBookConcordance[sn]
    return "The word “" .. entry.enlexeme .. "” (" .. entry.t1lexeme .. ") is repeated " .. count .. " times (" .. list .. ")."
end

vim.api.nvim_create_user_command("RangeCountSnPrint", function(opts) print(range_count_sn(opts.fargs[1])) end, { nargs = 1 })

vim.api.nvim_create_user_command("RangeCountSnPaste", function(opts) vim.api.nvim_paste(range_count_sn(opts.fargs[1]), true, -1) end, { nargs = 1 })

function range_close_words(entries_length, ...)

    function _entry_matches_strs(entry, strs)
        for str,_ in pairs(strs) do
            if _entry_matches_str(entry, str) then
                return true
            end
        end
        return false
    end

    local strs = {}
    local strs_length = 0
    for _,word in pairs({...}) do
        strs[word] = true
        strs_length = strs_length + 1
    end

    local entries = {}
    local n = 0
    local j = 0

    for _,entry in pairs(vim.g.OgntRangeWords) do
        -- build the current entries
        n = n + 1
        if n <= entries_length then
            entries[n] = entry
        else
            for j=1,entries_length-1 do
                entries[j] = entries[j+1]
            end
            entries[entries_length] = entry
        end
        -- check matches in the current entries
        if n >= entries_length then
            if _entry_matches_strs(entries[1], strs) then
                local matches = 1
                for j=2,entries_length do
                    if _entry_matches_strs(entries[j], strs) then
                        matches = matches + 1
                    end
                end
                if matches >= strs_length then
                    local addr = entries[1].addr
                    local t2_text = ""
                    for j=1,entries_length do
                        t2_text = t2_text .. " " .. entries[j].t2
                    end
                    print(addr, t2_text)
                end
            end
        end
    end
end

vim.api.nvim_create_user_command("RangeCloseWords",
    function(opts)
        range_close_words(tonumber(opts.fargs[1]), opts.fargs[2], opts.fargs[3], opts.fargs[4], opts.fargs[5], opts.fargs[6], opts.fargs[7], opts.fargs[8])
    end, { nargs = "*" })

if vim.g.OgntBook then
    load_book()
end

