module test_threekingdoms_地名

using Test
using ThreeKingdoms.地名 # 郡 縣
using AbstractTrees # print_tree

상산군 = 郡("상산군", [縣("구문현"), 縣("난성현"), 縣("남행당현"), 縣("도향현"), 縣("방자현"), 縣("상애현"), 縣("영수현"), 縣("원씨현"), 縣("정형현"), 縣("진정현"), 縣("평극현"), 縣("포오현")])
# print_tree(상산군)

@test 縣("진정현") in 상산군.縣

end # module test_threekingdoms_地名
