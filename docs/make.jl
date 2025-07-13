using Documenter
using DocumenterVitepress
using NASAMergedTb
import CairoMakie

CairoMakie.activate!(type = "svg")

DocMeta.setdocmeta!(NASAMergedTb, :DocTestSetup, :(using GeoRegions); recursive=true)

makedocs(;
    modules  = [NASAMergedTb],
    authors  = "Nathanael Wong <natgeo.wong@outlook.com>",
    sitename = "NASAMergedTb.jl",
    doctest  = false,
    warnonly = true,
    format   = DocumenterVitepress.MarkdownVitepress(
        repo = "https://github.com/GeoRegionsEcosystem/NASAMergedTb.jl",
    ),
    pages=[
        "Home"                 => "index.md"
        # "What is a GeoRegion?" => "georegions.md",
        # "Basics"               => [
        #     "Load/Read a GeoRegion"     => "basics/read.md",
        #     "Creating a GeoRegion"      => "basics/create.md",
        #     "Shape of a GeoRegion"      => "basics/shape.md",
        #     "List Available GeoRegions" => "basics/tables.md",
        #     "Predefined GeoRegions"     => [
        #         "Predefined Datasets" => "basics/predefined/datasets.md",
        #         "List All GeoRegions" => "basics/predefined/listall.md",
        #     ],
        # ],
        # "Tutorials"            => [
        #     "Using GeoRegions.jl"          => [
        #         "Is it in a GeoRegion?"        => "tutorials/using/isin.md",
        #         "Is it on a GeoRegion?"        => "tutorials/using/ison.md",
        #         "Equivalence in GeoRegions.jl" => "tutorials/using/isequal.md",
        #         "Derotation of Coordinates"    => "tutorials/using/derotate.md",
        #     ],
        #     "GeoRegions.jl for Projects"   => [
        #         "Setting Up"        => "tutorials/projects/setup.md",
        #         "Add, Read, Remove" => "tutorials/projects/addreadrm.md",
        #         "Backends"          => "tutorials/projects/backends.md",
        #     ],
        # ],
        # "API"                  => [
        #     "Create, Add, Read, Remove" => "api/createaddreadrm.md",
        #     "Project Setup"             => "api/project.md",
        #     "Tables"                    => "api/tables.md",
        #     "Shape / Coordinates"       => "api/shape.md",
        #     "Derotate"                  => "api/derotation.md",
        #     "Is In/On/Equal?"           => "api/isinonequal.md",
        # ],
        # "Ecosystem"            => "ecosystem.md",
    ],
)

recursive_find(directory, pattern) =
    mapreduce(vcat, walkdir(directory)) do (root, dirs, files)
        joinpath.(root, filter(contains(pattern), files))
    end

files = []
for pattern in [r"\.cst", r"\.nc", "test.geo"]
    global files = vcat(files, recursive_find(@__DIR__, pattern))
end

for file in files
    rm(file)
end

DocumenterVitepress.deploydocs(;
    repo      = "github.com/GeoRegionsEcosystem/NASAMergedTb.jl.git",
    target    = "build", # this is where Vitepress stores its output
    devbranch = "main",
    branch    = "gh-pages",
    push_preview = true,
)
