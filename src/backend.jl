## DateString Aliasing
yrmo2dir(date::TimeType) = Dates.format(date,dateformat"yyyy/mm")
yrmo2str(date::TimeType) = Dates.format(date,dateformat"yyyymm")
yr2str(date::TimeType)   = Dates.format(date,dateformat"yyyy")
ymd2str(date::TimeType)  = Dates.format(date,dateformat"yyyymmdd")

function btdlonlat()
    lon = convert(Array,range(-180,180,length=9897))
    lat = convert(Array,range(-60,60,length=3299))
    return (lon[1:(end-1)] .+ lon[2:end])./2, (lat[1:(end-1)] .+ lat[2:end])./2
end

function checkdates(
    dtbeg :: TimeType,
    dtend :: TimeType
)

    if dtbeg < Date(1998,1,1)
        error("$(modulelog()) - You have specified a date that is before the earliest available date of the NASA MERG Brightness Temperature, 1998-01-01.")
    end

    if dtend > (Dates.now() - Day(3))
        error("$(modulelog()) - You have specified a date that is later than the latest available date of the NASA MERG Brightness Temperature, $(now() - Day(3)).")
    end

end

function nanmean(
    data :: AbstractArray,
    dNaN :: AbstractArray
)
    nNaN = length(dNaN)
    for iNaN in 1 : nNaN
        dNaN[iNaN] = !isnan(data[iNaN])
    end
    dataii = @view data[dNaN]
    if !isempty(dataii); return mean(dataii); else; return NaN; end
end

function nanmean(
    data :: AbstractArray,
    dNaN :: AbstractArray,
    wgts :: AbstractArray,
)
    nNaN = length(dNaN)
    for iNaN in 1 : nNaN
        dNaN[iNaN] = !isnan(data[iNaN])
    end
    dataii = view(data,dNaN) .* view(wgts,dNaN)
    wgtsii = view(wgts,dNaN)
    if !isempty(dataii); return sum(dataii) / sum(wgtsii); else; return NaN; end
end