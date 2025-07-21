"""
    download(
        btd :: NASAPrecipitationDataset,
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
function fill(
	btd :: TbDataset{ST,DT},
	geo :: GeoRegion = GeoRegion("GLB");
	overwrite :: Bool = false
) where {ST<:AbstractString, DT<:TimeType}

	lon,lat = btdlonlat()
	ggrd = RegionGrid(geo,lon,lat)
	glon = ggrd.lon; nglon = length(glon);
	glat = ggrd.lat; nglat = length(glat);
	var  = zeros(Float32,nglon,nglat,48)
	vari = zeros(Float32,nglon,nglat,48) * NaN32
	mask = ones(Float32,nglon,nglat,48)

	for dt in btd.start : Day(1) : btd.stop

		fnc = btdfnc(btd,geo,dt)

		if isfile(fnc)

			ds = read(btd,geo,dt)
			NCDatasets.load!(ds["Tb"].var,var,:,:,:)
			close(ds)

			for ilat = 1 : nglat, ilon = 1 : nglon

				if !isnan(ggrd.mask[ilon,ilat])
					for ihr = 1 : 48
						if isnan(var[ilon,ilat,ihr])
							lonb = -1; lone = 1; latb = -1; late = 1
							if isone(ilon); lonb = 0; elseif ilon == nglon; lone = 0 end
							if isone(ilat); latb = 0; elseif ilat == nglat; late = 0 end
							tmp1 = @view var[ilon.+(lonb:lone),ilat.+(latb:late),ihr]
							tmp1 = @view tmp1[.!isnan.(tmp1)]
							mask[ilon,ilat,ihr] = mean(.!isnan.(tmp1))
							if !isempty(tmp1)
								 vari[ilon,ilat,ihr] = round(mean(tmp1)) # Round to nearest integer like the data
							else vari[ilon,ilat,ihr] = NaN32
							end
						else
							vari[ilon,ilat,ihr] = var[ilon,ilat,ihr]
						end
					end
				end

			end

			savefill(vari,dt,btd,geo,ggrd,mask)

		else

			@warn "$(modulelog()) - The file $fnc for $(btd.name) data for the $(geo.name) GeoRegion does not exist, skipping to the next timestep ..."

		end

		flush(stderr)

	end

end