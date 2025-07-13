"""
    TbDataset

The `TbDataset` Type contains the following fields:
* `ID`    : ID for the `TbDataset`, used in determining containing folders and filenames of the NetCDF
* `name`  : The name describing the `TbDataset`, used mostly in Logging
* `doi`   : The DOI identifier, to be saved into the NetCDF
* `start` : The start date (Y,M,D) of our download / analysis
* `stop`  : The end date (Y,M,D) of our download / analysis
* `path` : The directory in which to save our downloads and analysis files to
* `hroot` : The URL of the NASA's EOSDIS OPeNDAP server for which this dataset is stored
* `fpref` : The prefix component of the NetCDF files to be downloaded
* `fsuff` : The suffix component of the NetCDF files to be downloaded
"""

struct TbDataset{ST<:AbstractString, DT<:TimeType}
    ID    :: ST
    name  :: ST
    doi   :: ST
    start :: DT
    stop  :: DT
    path  :: ST
    hroot :: ST
    fpref :: ST
    fsuff :: ST
end

"""
    TbDataset(
        ST = String,
        DT = Date;
        start :: TimeType,
        stop  :: TimeType,
        path :: AbstractString = homedir(),
    ) -> btd :: TbDataset{ST,DT}

Creates a `TbDataset` dataset `btd` to store information on the Brightness Temperature dataset

Keyword Arguments
=================
- `start` : Date at which download / analysis of the dataset begins
- `stop ` : Date at which download / analysis of the dataset ends
- `path` : The directory in which the folder `imergearlydy` will be created for data downloads, storage and analysis, default is the home directoy called by `homedir()`

The following fields in `btd` will be fixed as below:
- `ID` : tb
- `name` : Brightness Temperature
- `doi` : 10.5067/P4HZB9N27EKU
- `hroot` : https://disc2.gesdisc.eosdis.nasa.gov/opendap/MERGED_IR/GPM_MERGIR.1
- `fpref` : merg
- `fsuff` : 4km-pixel.nc4
"""
function TbDataset(
    ST = String,
    DT = Date;
    start :: TimeType = Date(1998),
    stop  :: TimeType = Dates.now() - Day(3),
    path  :: AbstractString = homedir(),
)

    @info "$(modulelog()) - Setting up data structure containing information on NASA Brightness Temperature data to be downloaded"

    fol = joinpath(path,"tb"); if !isdir(fol); mkpath(fol) end
    checkdates(start,stop)

    return TbDataset{ST,DT}(
		"tb", "Brightness Temperature", "10.5067/P4HZB9N27EKU",
        start, stop,
		joinpath(path,"tb"),
        "https://disc2.gesdisc.eosdis.nasa.gov/opendap/MERGED_IR/GPM_MERGIR.1",
        "merg", "4km-pixel.nc4",
    )

end

function show(
    io  :: IO,
    btd :: TbDataset{ST,DT}
) where {ST<:AbstractString, DT<:TimeType}

    print(
		io,
		"The NASA Brightness Temperature Dataset {$ST,$DT} has the following properties:\n",
		"    Dataset ID           (ID) : ", btd.ID, '\n',
		"    Logging Name       (name) : ", btd.name, '\n',
		"    DOI URL             (doi) : ", btd.doi,   '\n',
		"    Data Directory     (path) : ", btd.path, '\n',
		"    Date Begin        (start) : ", btd.start, '\n',
		"    Date End           (stop) : ", btd.stop , '\n',
		"    Timestep                  : Half Hourly\n",
        "    Data Resolution           : 4 km\n",
        "    Data Server       (hroot) : ", btd.hroot, '\n',
	)
    
end