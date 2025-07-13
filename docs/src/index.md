```@raw html
---
layout: home

hero:
  name: "NASAMergedTb.jl"
  text: "Gridded Brightness Temperature to Understand Clouds"
  tagline: Handling NASA's NCEP/CPC Level 3 Merged Infrared Brightness Temperature Dataset in Julia
  image:
    src: /logo.png
    alt: NASAMergedTb
  actions:
    - theme: brand
      text: Getting Started
      link: /basics
    - theme: alt
      text: Tutorials
      link: /tutorials
    - theme: alt
      text: View on Github
      link: https://github.com/GeoRegionsEcosystem/NASAMergedTb.jl
      

features:
  - title: 🔍 Simple and Intuitive
    details: NASAMergedTb aims to be simple and intuitive to the user, with basic functions like `download()` and `read()`.
  - title: 🌍 Region of Interest
    details: You don't have to download the global dataset, only for your (Geo)Region of interest, saving you time and disk space for small domains.
  - title: 🏔️ Analysis
    details: With NASAMergedTb, find regions of Shallow and Deep Convection/Clouds for your analysis based on your thresholds.
---


---
```

## Installation Instructions

The latest version of NASAMergedTb can be installed using the Julia package manager (accessed by pressing `]` in the Julia command prompt)
```julia-repl
julia> ]
(@v1.10) pkg> add NASAMergedTb
```

You can update `NASAMergedTb.jl` to the latest version using
```julia-repl
(@v1.10) pkg> update NASAMergedTb
```

And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn't necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the `main` branch of the GitHub repository:
```julia-repl
(@v1.10) pkg> add NASAMergedTb#main
```

## Getting help
If you are interested in using `NASAMergedTb.jl` or are trying to figure out how to use it, please feel free to ask me questions and get in touch!  Please feel free to [open an issue](https://github.com/GeoRegionsEcosystem/NASAMergedTb.jl/issues/new) if you have any questions, comments, suggestions, etc!
