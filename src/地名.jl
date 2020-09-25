module 地名 # ThreeKingdoms

export 州, 郡, 縣

using AbstractTrees

# 나무위키 삼국지/지명
# https://namu.wiki/w/%EC%82%BC%EA%B5%AD%EC%A7%80/%EC%A7%80%EB%AA%85

abstract type 行政區域; end # 행정구역

struct 縣 <: 行政區域 # 현
    名::String
end

struct 郡 <: 行政區域 # 군
    名::String
    郡縣::Vector{Union{郡,縣}}
    function 郡(名::String, 郡縣=Union{郡,縣}[])
        new(名, 郡縣)
    end
end

struct 州 <: 行政區域 # 주
    名::String
    이름::String
    Name::String
    郡::Vector{郡}
    function 州(名::String, 郡::Vector{郡} = 郡[])
        new(名, "", "", 郡)
    end
    function 州(; 名, 이름, Name)
        new(名, 이름, Name, 郡[])
    end
end

AbstractTrees.children(군::郡) = 군.郡縣
AbstractTrees.children(주::州) = 주.郡

const 司隸 = 州(名 = "司隸", 이름 = "사례", Name = "Sili")
const 冀州 = 州(名 = "冀州", 이름 = "기주", Name = "Jizhou")
const 幽州 = 州(名 = "幽州", 이름 = "유주", Name = "Youzhou")
const 并州 = 州(名 = "并州", 이름 = "병주", Name = "Bingzhou")
const 涼州 = 州(名 = "涼州", 이름 = "량주", Name = "Liangzhou")
const 益州 = 州(名 = "益州", 이름 = "익주", Name = "Yizhou")
const 交州 = 州(名 = "交州", 이름 = "교주", Name = "Jiaozhou")
const 荊州 = 州(名 = "荊州", 이름 = "형주", Name = "Jingzhou")
const 揚州 = 州(名 = "揚州", 이름 = "양주", Name = "Yangzhou")
const 豫州 = 州(名 = "豫州", 이름 = "예주", Name = "Yuzhou")
const 徐州 = 州(名 = "徐州", 이름 = "서주", Name = "Xuzhou")
const 青州 = 州(名 = "青州", 이름 = "청주", Name = "Qingzhou")
const 兗州 = 州(名 = "兗州", 이름 = "연주", Name = "Yanzhou")
const 代州 = 州(名 = "代州", 이름 = "대주", Name = "Daizhou")
const 雍州 = 州(名 = "雍州", 이름 = "옹주", Name = "Yongzhou")

const 疆埸 = Dict( # 강역
    "司隸" => 司隸,
    "冀州" => 冀州,
    "幽州" => 幽州,
    "并州" => 并州,
    "涼州" => 涼州,
    "益州" => 益州,
    "交州" => 交州,
    "荊州" => 荊州,
    "揚州" => 揚州,
    "豫州" => 豫州,
    "徐州" => 徐州,
    "青州" => 青州,
    "兗州" => 兗州,
    "代州" => 代州,
    "雍州" => 雍州,
)

end # ThreeKingdoms.地名
