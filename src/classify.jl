"""
    classify(
        btd :: TbDataset,
        geo :: GeoRegion = GeoRegion("GLB");
	    overwrite :: Bool = false
    ) -> nothing

Downloads a NASA Precipitation dataset specified by `btd` for a GeoRegion specified by `geo`

Arguments
=========
- `btd` : a `NASAPrecipitationDataset` specifying the dataset details and date download range
- `geo` : a `GeoRegion` (see [GeoRegions.jl](https://github.com/JuliaClimate/GeoRegions.jl)) that sets the geographic bounds of the data array in lon-lat

Keyword Arguments
=================
- `overwrite` : If `true`, overwrite any existing files
"""
function classify(
	btd :: TbDataset{ST,DT},
	geo :: GeoRegion = GeoRegion("NASATB",path=geopath);
	shallow  :: Int,
	deep     :: Int,
	overwrite :: Bool = false
) where {ST<:AbstractString, DT<:TimeType}

	geo.ID == "NASATB" ? in(geo,GeoRegion("NASATB",path=geopath)) : nothing
	
	sdd = SDDataset(btd,shallow=shallow,deep=deep)
	lon,lat = btdlonlat()
	ggrd = RegionGrid(geo,lon,lat)
	glon = ggrd.lon; nglon = length(glon);
	glat = ggrd.lat; nglat = length(glat);
	var  = zeros(Float32,nglon,nglat,48)
	clss = zeros(Float32,nglon,nglat,48) * NaN32
	mask = ones(Float32,nglon,nglat,48)

	for dt in btd.start : Day(1) : btd.stop

		fnc = btdfnc(btd,geo,dt)
		snc = sddfnc(sdd,geo,dt)

		if isfile(fnc) && (overwrite || !isfile(snc))

			ds = read(btd,geo,dt)
			NCDatasets.load!(ds["Tb"].var,var,:,:,:)
			NCDatasets.load!(ds["mask"].var,mask,:,:,:)
			close(ds)

			for ilat = 1 : nglat, ilon = 1 : nglon

				if !isnan(ggrd.mask[ilon,ilat])
					for ihr = 1 : 48
						idata = var[ilon,ilat,ihr]
						if idata > shallow
							clss[ilon,ilat,ihr] = 0
						elseif idata <= deep
							clss[ilon,ilat,ihr] = 2
						else
							clss[ilon,ilat,ihr] = 1
						end
					end
				end

			end

			save(clss,mask,dt,sdd,geo,ggrd)

		else

			@warn "$(modulelog()) - The file $fnc for $(btd.name) data for the $(geo.name) GeoRegion does not exist, skipping to the next timestep ..."

		end

		flush(stderr)

	end

end