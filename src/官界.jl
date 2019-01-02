module 官界 # ThreeKingdoms

using ..地名

export 官職, 太守, 縣令, 縣長


# 나무위키 삼국지/관직
# https://namu.wiki/w/%EC%82%BC%EA%B5%AD%EC%A7%80/%EA%B4%80%EC%A7%81

abstract type 官職 end

struct 太守 <: 官職
    管轄::地名.郡
end

struct 縣令 <: 官職
    管轄::地名.縣
end

struct 縣長 <: 官職
    管轄::地名.縣
end

end # module ThreeKingdoms.官界
