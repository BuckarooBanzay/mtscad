return function(ctx)
    ctx
    :with({ name="default:cobble" })
    :polygon({
        -- x, y (triangle)
        {0,0},
        {0,10},
        {10,0}
    }, true)
end