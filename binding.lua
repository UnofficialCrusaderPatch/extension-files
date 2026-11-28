return function(pattern)
    local ok, site = pcall(core.AOBScan, pattern)
    assert(ok, "not found (" .. pattern .. ")")
    return site
end
