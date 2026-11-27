return function(pattern)
    local site, reason = core.AOBScanUnique(pattern)
    assert(site, tostring(reason) .. " (" .. pattern .. ")")
    return site
end
