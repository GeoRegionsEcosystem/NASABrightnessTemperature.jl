# The Basics of NASAMergedTb.jl

There are two essential components in NASAMergedTb.jl

* The NASA Level 3 Brightness Temperature Dataset (i.e., a TbDataset `btd`)
* A geographic region of interest (i.e., a GeoRegion `geo`)

With these two components, you can perform the following actions:

* Download data of interest using `download(btd,geo)`
* Perform basic analysis on the data using `analysis(btd,geo)`
* Manipulate the data (e.g., spatiotemporal smoothing using `smooth(btd,geo,...)`)
* Determine regions of shallow and deep convection depending your specified thresholds

## The `TbDataset` Type

The `TbDataset` type contains the following information:
* `start` - The beginning of the date-range of our data of interest
* `stop` - The end of the date-range of our data of interest
* `path` - The data directory in which our dataset is saved into

```@docs
NASAMergedTb.TbDataset
```

Defining a `TbDataset` is easy, all you have to define are two things:
1. Date range, ranging from `start` to `stop`
2. Data `path`, i.e. where you want to save the NASA Brightness Temperature Data

```
TbDataset(
    start = Date(),
    stop  = Date(),
    path  = ...
)
```

See below for an example of defining an `TbDataset`
```@repl
using NASAMergedTb
npd = TbDataset(start=Date(2017,2,1),stop=Date(2017,2,1),path=homedir())
npd.start
npd.path
```

## The `AbstractGeoRegion` Type

A `GeoRegion` defines the geometry/geometries of geograhical region(s) of interest. See the [documentation of GeoRegions.jl](https://georegionsecosystem.github.io/GeoRegions.jl/dev/georegions) for more information.

```@docs
GeoRegions.AbstractGeoRegion
```