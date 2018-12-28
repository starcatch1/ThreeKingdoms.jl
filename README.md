# ThreeKingdoms

|  **Build Status**                                               |
|:---------------------------------------------------------------:|
|  [![][travis-img]][travis-url]  [![][codecov-img]][codecov-url] |

```
julia> using ThreeKingdoms: 人名錄

julia> findfirst(人名錄.登場人物) do 인물
           인물.이름 == "조운"
       end
"趙雲"

julia> 人名錄.趙雲
(名 = "趙雲", 이름 = "조운")
```


[travis-img]: https://api.travis-ci.org/wookay/ThreeKingdoms.jl.svg?branch=master
[travis-url]: https://travis-ci.org/wookay/ThreeKingdoms.jl

[codecov-img]: https://codecov.io/gh/wookay/ThreeKingdoms.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/wookay/ThreeKingdoms.jl/branch/master
