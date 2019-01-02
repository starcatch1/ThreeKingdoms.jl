module test_threekingdoms_官界

using Test
using ThreeKingdoms.地名 # 郡 縣
using ThreeKingdoms.官界 # 官職 太守 縣令 縣長

상산군 = 郡("상산군", [縣("전정현")])
상산군태수 = 太守(상산군)
@test 상산군태수 isa 官職

end # module test_threekingdoms_官界
