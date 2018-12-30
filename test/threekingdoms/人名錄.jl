module test_threekingdoms_人名錄

using ThreeKingdoms: 人名錄
using Test

@test 人名錄.賈詡 == 人名錄.登場人物["賈詡"] == (名 = "賈詡", 字 = "文和", 이름 = "가후", 자 = "문화")
@test 人名錄.賈詡.이름 == "가후"

JiaXu = findfirst(人名錄.登場人物) do 인물
    인물.이름 == "가후"
end
@test JiaXu == "賈詡"

end # module test_threekingdoms_人名錄
