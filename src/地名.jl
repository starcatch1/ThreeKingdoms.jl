module 地名 # ThreeKingdoms

export 郡, 縣

using AbstractTrees

# 나무위키 삼국지/지명
# https://namu.wiki/w/%EC%82%BC%EA%B5%AD%EC%A7%80/%EC%A7%80%EB%AA%85

struct 縣
    名::String
end

struct 郡
    名::String
    縣::Vector{縣}
end

AbstractTrees.children(군::郡) = 군.縣

end # ThreeKingdoms.地名
