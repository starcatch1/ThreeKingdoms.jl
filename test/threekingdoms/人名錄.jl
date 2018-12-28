module test_threekingdoms_人名錄

using ThreeKingdoms: 人名錄
using Test

@test 人名錄.賈詡.이름 == "가후"
@test 人名錄.人民名單["賈詡"] == 人名錄.賈詡
@test findfirst(x -> x.이름=="가후", 人名錄.人民名單) == "賈詡"

end # module test_threekingdoms_人名錄
