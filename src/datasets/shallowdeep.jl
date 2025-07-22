"""
    SDDataset

The `SDDataset` Type contains the following fields:
* `ID`    : ID for the `SDDataset`, used in determining containing folders and filenames of the NetCDF
* `name`  : The name describing the `SDDataset`, used mostly in Logging
* `start` : The start date (Y,M,D) of our download / analysis
* `stop`  : The end date (Y,M,D) of our download / analysis
* `path` : The directory in which to save our downloads and analysis files to
* `shallow` : The temperature threshold for shallow clouds (inclusive of)
* `deep` : The temperature threshold for deep convective clouds (inclusive of)
"""
struct SDDataset{ST<:AbstractString, DT<:TimeType}
    ID    :: ST
    name  :: ST
    start :: DT
    stop  :: DT
    path  :: ST
    shallow :: Int
    deep    :: Int
end

"""
    SDDataset(
        ST = String,
        DT = Date;
        start :: TimeType = Date(1998),
        stop  :: TimeType = Dates.now() - Day(3),
        path  :: AbstractString = homedir(),
        shallow :: Int,
        deep    :: Int
    ) -> ssd :: SDDataset{ST,DT}

Creates a `SDDataset` dataset `ssd` to store information on the Merged-IR Shallow/Deep Classification dataset

Keyword Arguments
=================
- `start` : Date at which download / analysis of the dataset begins
- `stop ` : Date at which download / analysis of the dataset ends
- `path` : The directory in which the folder `imergearlydy` will be created for data downloads, storage and analysis, default is the home directoy called by `homedir()`
- `shallow` : The temperature threshold for shallow clouds (inclusive of)
- `deep` : The temperature threshold for deep convective clouds (inclusive of)

The following fields in `ssd` will be fixed as below:
- `ID` : class
- `name` : NASA Merged-IR Shallow/Deep Classification
"""
function SDDataset(
    ST = String,
    DT = Date;
    start :: TimeType = Date(1998),
    stop  :: TimeType = Dates.now() - Day(3),
    path  :: AbstractString = homedir(),
    shallow :: Int,
    deep    :: Int
)

    @info "$(modulelog()) - Setting up data structure containing information on NASA Merged-IR Shallow/Deep Classification"

    fol = mergIRpath(path); if !isdir(fol); mkpath(fol) end
    checkdates(start,stop)

    return SDDataset{ST,DT}(
		"class", "NASA Merged-IR Shallow/Deep Classification",
        start, stop, fol, shallow, deep
    )

end

"""
    SDDataset(
        btd :: TbDataset{ST,DT};
        shallow :: Int,
        deep    :: Int
    ) where {ST<:AbstractString, DT<:TimeType} -> ssd :: SDDataset{ST,DT}

Creates a `SDDataset` dataset `ssd` based on the Brightness Temperature dataset `btd` to store the Merged-IR Shallow/Deep Classification information

Keyword Arguments
=================
- `btd` : The Brightness Temperature dataset. Start, stop and path variables will be taken from this dataset.
- `shallow` : The temperature threshold for shallow clouds (inclusive of)
- `deep` : The temperature threshold for deep convective clouds (inclusive of)
"""
function SDDataset(
    btd :: TbDataset{ST,DT};
    shallow :: Int,
    deep    :: Int
) where {ST<:AbstractString, DT<:TimeType}

    @info "$(modulelog()) - Setting up data structure containing information on NASA Merged-IR Shallow/Deep Classification"

    fol = mergIRpath(btd.path); if !isdir(fol); mkpath(fol) end
    checkdates(btd.start,btd.stop)

    return SDDataset{ST,DT}(
		"class", "NASA Merged-IR Shallow/Deep Classification",
        btd.start, btd.stop, fol, shallow, deep
    )

end

function show(
    io  :: IO,
    sdd :: SDDataset{ST,DT}
) where {ST<:AbstractString, DT<:TimeType}

    print(
		io,
		"The $(sdd.name) Dataset {$ST,$DT} has the following properties:\n",
		"    Dataset ID           (ID) : ", sdd.ID, '\n',
		"    Logging Name       (name) : ", sdd.name, '\n',
		"    Data Directory     (path) : ", sdd.path, '\n',
		"    Date Begin        (start) : ", sdd.start, '\n',
		"    Date End           (stop) : ", sdd.stop , '\n',
		"    Timestep                  : Half Hourly\n",
        "    Data Resolution           : 4 km\n",
		"    Threshold (shallow, deep) : $(sdd.shallow) K, $(sdd.deep) K" , '\n'
	)
    
end