function save(
	var  :: AbstractArray{Float32,3},
	dt   :: TimeType,
	btd  :: TbDataset,
	geo  :: GeoRegion,
	ggrd :: RegionGrid,
	mask :: AbstractArray{Float32,3};
    smooth     :: Bool = false,
    smoothlon  :: Real = 0,
    smoothlat  :: Real = 0,
    smoothtime :: Int = 0,
)

	@info "$(modulelog()) - Saving $(btd.name) data in the $(geo.name) GeoRegion for $(dt)"

	fnc = btdfnc(btd,geo,dt)
	if smooth
        fnc = btdsmth(btd,geo,dt,smoothlon,smoothlat,smoothtime)
    end
	if !isdir(dirname(fnc)); mkpath(dirname(fnc)) end
	if isfile(fnc)
		@info "$(modulelog()) - Overwrite stale NetCDF file $(fnc) ..."
        rm(fnc)
	end
	@info "$(modulelog()) - Creating NetCDF file $(fnc) ..."
	pds = NCDataset(fnc,"c",attrib = Dict(
        "doi" => btd.doi
    ))

	pds.dim["longitude"] = length(ggrd.lon)
	pds.dim["latitude"]  = length(ggrd.lat)
	pds.dim["time"]      = size(var,3)

	nclon = defVar(pds,"longitude",Float32,("longitude",),attrib = Dict(
	    "units"         => "degrees_east",
	    "standard_name" => "longitude",
	))

	nclat = defVar(pds,"latitude",Float32,("latitude",),attrib = Dict(
	    "units"         => "degrees_north",
	    "standard_name" => "latitude",
	))

	ncvar = defVar(pds,"Tb",Float32,("longitude","latitude","time"),attrib = Dict(
	    "units"         => "K",
	    "standard_name" => "brightness_temperature",
		"full_name"     => "Brightness Temperature",
	))

	ncmsk = defVar(pds,"mask",Float32,("longitude","latitude","time"),attrib = Dict(
	    "units"         => "0-1",
		"full_name"     => "Valid Mask (3x3)",
	))

	nclon[:] = ggrd.lon
	nclat[:] = ggrd.lat
	ncvar[:,:,:] = var
	ncmsk[:,:,:] = mask

	close(pds)

	@info "$(modulelog()) - $(btd.name) data in the $(geo.name) GeoRegion for $(dt) has been saved into $(fnc)"

end