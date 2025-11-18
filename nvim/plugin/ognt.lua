
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

function _output(text)
    if text then
        vim.fn.setreg("*", text)
        print(text)
    end
end

function copy_text(addr, count, bang)
    local j = 0
    local verse
    local en
    local t1
    for _,entry in pairs(vim.g.OgntBookWords) do
        if entry.addr == addr then
            j = tonumber(count)
            verse = entry.verse
        end
        if j > 0 then
            if en then
                en = en .. " " .. entry.en
            else
                en = entry.en
            end
            if t1 then
                t1 = t1 .. " " .. entry.t1
            else
                t1 = entry.t1
            end
            j = j - 1
        end
    end
    if verse then
        local result = "“" .. en .. "” ("
        if bang then
            result = result .. t1 .. ", " 
        end
        result = result .. verse .. ")"
        _output(result)
    end
end

vim.api.nvim_create_user_command("OgntCopyText", function(opts) copy_text(opts.fargs[1], opts.fargs[2], opts.bang) end, { nargs = "*", bang = true })

function concordance_info(entry)
    return entry.sn .. " " ..
           entry.grlexeme .. " " ..
           entry.t1lexeme .. " " ..
           entry.t2lexeme .. " " ..
           entry.enlexeme .. " " ..
           entry.count .. " (" ..
           entry.verses .. ")"
end

function _concordance_matches_str(entry, str)
    return entry.sn == str or string.match(entry.enlexeme, str) or string.match(entry.t2lexeme, str)
end

function concordance(str)
    local result
    for _,entry in pairs(vim.g.OgntBookConcordance) do
        if _concordance_matches_str(entry, str) then
            if result then
                result = result .. "\n" .. concordance_info(entry)
            else
                result = concordance_info(entry)
            end
        end
    end
    _output(result)
end

vim.api.nvim_create_user_command("OgntConcordance", function(opts) concordance(opts.fargs[1]) end, { nargs = 1 })

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

vim.api.nvim_create_user_command("OgntRange", function(opts) range(opts.fargs[1], opts.fargs[2]) end, { nargs = "*" })

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

function find(words, str)
    for _,entry in pairs(words) do
        if _entry_matches_str(entry, str) then
            print(word_info(entry))
        end
    end
end

vim.api.nvim_create_user_command("OgntBookFind", function(opts) find(vim.g.OgntBookWords, opts.fargs[1]) end, { nargs = 1 })
vim.api.nvim_create_user_command("OgntRangeFind", function(opts) find(vim.g.OgntRangeWords, opts.fargs[1]) end, { nargs = 1 })

function sn_data(words, sn)

    local verses = {}
    local list = ""
    local count = 0

    for k,v in pairs(words) do
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
    return entry, list, count
end

function sn(words, sn, bang)
    local entry, list, count = sn_data(words, sn)
    if entry then
        local result = "“" .. entry.enlexeme .. "” ("
        if bang then
            result = result .. entry.t1lexeme .. ", "
        end
        result = result .. list .. ")"
        _output(result)
    else
        error("Entry " .. sn .. " not found")
    end
end

function sn_count(words, sn, bang)
    local entry, list, count = sn_data(words, sn)
        local result = "“" .. entry.enlexeme .. "” ("
        if bang then
            result = result .. entry.t1lexeme .. ", "
        end
        result = result .. list .. ") is repeated " .. count .. " times."
    _output(result)
end

function sn_list(words, sn)
    local entry, list, count = sn_data(words, sn)
    _output("(" .. list .. ")")
end

vim.api.nvim_create_user_command("OgntBookSn", function(opts) sn(vim.g.OgntBookWords, opts.fargs[1], opts.bang) end, { nargs = 1, bang = true })
vim.api.nvim_create_user_command("OgntBookSnCount", function(opts) sn_count(vim.g.OgntBookWords, opts.fargs[1], opts.bang) end, { nargs = 1, bang = true })
vim.api.nvim_create_user_command("OgntBookSnList", function(opts) sn_list(vim.g.OgntBookWords, opts.fargs[1]) end, { nargs = 1 })
vim.api.nvim_create_user_command("OgntRangeSn", function(opts) sn(vim.g.OgntRangeWords, opts.fargs[1], opts.bang) end, { nargs = 1, bang = true })
vim.api.nvim_create_user_command("OgntRangeSnCount", function(opts) sn_count(vim.g.OgntRangeWords, opts.fargs[1], opts.bang) end, { nargs = 1, bang = true })
vim.api.nvim_create_user_command("OgntRangeSnList", function(opts) sn_list(vim.g.OgntRangeWords, opts.fargs[1]) end, { nargs = 1 })

function close_words(words, entries_length, ...)

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
    local result

    for _,entry in pairs(words) do
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
                    local output = addr .. " " .. t2_text
                    if result then
                        result = result .. "\n" .. output
                    else
                        result = output
                    end
                end
            end
        end
    end
    _output(result)
end

vim.api.nvim_create_user_command("OgntRangeCloseWords",
    function(opts)
        close_words(vim.g.OgntRangeWords, tonumber(opts.fargs[1]), opts.fargs[2], opts.fargs[3], opts.fargs[4], opts.fargs[5], opts.fargs[6], opts.fargs[7], opts.fargs[8])
    end, { nargs = "*" })

vim.api.nvim_create_user_command("OgntBookCloseWords",
    function(opts)
        close_words(vim.g.OgntBookWords, tonumber(opts.fargs[1]), opts.fargs[2], opts.fargs[3], opts.fargs[4], opts.fargs[5], opts.fargs[6], opts.fargs[7], opts.fargs[8])
    end, { nargs = "*" })

if vim.g.OgntBook then
    load_book()
end

