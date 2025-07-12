---
layout: home

hero:
  name: "NASABrightnessTemperature.jl"
  text: "Handling NASA's MERG-IR Datasets"
  tagline: Download, extract and manipulate NASA's Brightness Temperature Dataset in Julia
  image:
    src: /logo.png
    alt: NASABrightnessTemperature
  actions:
    - theme: brand
      text: Getting Started
      link: /basics
    - theme: alt
      text: Datasets
      link: /datasets
    - theme: alt
      text: Tutorials
      link: /tutorials
    - theme: alt
      text: View on Github
      link: https://github.com/GeoRegionsEcosystem/NASABrightnessTemperature.jl
      

features:
  - title: 🔍 Simple and Intuitive
    details: NASABrightnessTemperature aims to be simple and intuitive to the user, with basic functions like `download()` and `read()`.
  - title: 🌍 Region of Interest
    details: You don't have to download the global dataset, only for your (Geo)Region of interest, saving you time and disk space for small domains.
  - title: 🏔️ Analysis
    details: With NASABrightnessTemperature, find regions of Shallow and Deep Convection/Clouds for your analysis based on your thresholds.
---


---


## Installation Instructions {#Installation-Instructions}

The latest version of NASABrightnessTemperature can be installed using the Julia package manager (accessed by pressing `]` in the Julia command prompt)

```julia
julia> ]
(@v1.10) pkg> add NASABrightnessTemperature
```


You can update `NASABrightnessTemperature.jl` to the latest version using

```julia
(@v1.10) pkg> update NASABrightnessTemperature
```


And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn&#39;t necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the `main` branch of the GitHub repository:

```julia
(@v1.10) pkg> add NASABrightnessTemperature#main
```


## Getting help {#Getting-help}

If you are interested in using `NASABrightnessTemperature.jl` or are trying to figure out how to use it, please feel free to ask me questions and get in touch!  Please feel free to [open an issue](https://github.com/GeoRegionsEcosystem/NASABrightnessTemperature.jl/issues/new) if you have any questions, comments, suggestions, etc!
