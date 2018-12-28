if VERSION < v"1.2.0-DEV"
    @warn "Julia 1.2 버전이 필요합니다"
    @warn "다운로드: https://julialang.org/downloads/nightlies.html"
end

using Pkg
if !haskey(Pkg.installed(), "ExcelReaders")
    Pkg.add("ExcelReaders")
end
using ExcelReaders
if ExcelReaders.xlrd == ExcelReaders.PyNULL()
    @warn "xlrd 설치를 하세요"
    @warn "예) pip3 install xlrd"
end


struct 도시타입
    이름::String
    은전시설::String
    군량시설::String
    크기::String
    점령여부::Bool
end

struct 장수타입
    이름::String
    태수효과::String
    계보::String
    등용여부::Bool
end

# 5:74
# 점령여부 E
# 도시명 F
# 은전 I
# 군량 H
# 크기 K
function get_cities(filename)::Vector{도시타입}
    도시들 = Vector{도시타입}()
    data = readxl(filename, "조조전온라인 태수 정리!E5:K74")
    for (점령, 이름, 지역, 군량, 은전, 태수, 크기) in eachrow(data)
        점령여부 = 점령 == "o"
        도시 = 도시타입(이름, 은전, 군량, 크기, 점령여부)
        push!(도시들, 도시)
    end
    return 도시들
end # function get_cities

# 4:516
# 등용여부 A
# 장수 B
# 태수효과 D
function get_generals(filename)::Vector{장수타입}
    장수들 = Vector{장수타입}()
    data = readxl(filename, "조조전온라인 태수 정리!A4:D516")
    current_계보 = ""
    for (등용, 이름, 연의, 태수효과) in eachrow(data)
        !isa(이름, String) && continue
        if 연의 == "연의"
            current_계보 = 이름
            continue
        end
        등용여부 = 등용 == "o"
        장수 = 장수타입(이름, 태수효과, current_계보, 등용여부)
        push!(장수들, 장수)
    end
    return 장수들
end # function get_generals

function nominate_viceroys(크기순_점령한_도시들, 등용한_장수들)
    후보군 = Dict{String,Union{장수타입,Nothing}}(도시.이름 => nothing for 도시 in 크기순_점령한_도시들)
    장수풀 = Dict{String,Int}(장수.이름 => 0 for 장수 in 등용한_장수들)

    function 적합한장수찾기(조건, 단계)
        남은도시들 = filter(도시 -> isa(후보군[도시.이름], Nothing), 크기순_점령한_도시들)
        남은장수들 = filter(장수 -> iszero(장수풀[장수.이름]), 등용한_장수들)
        for 도시 in 남은도시들
            for 장수 in 남은장수들
                if iszero(장수풀[장수.이름]) && 조건(장수, 도시)
                    후보군[도시.이름] = 장수
                    장수풀[장수.이름] = 단계
                    break
                end
            end
        end
    end

    적합한장수찾기(1) do 장수, 도시
        장수.태수효과 == 도시.은전시설
    end

    적합한장수찾기(2) do 장수, 도시
        장수.태수효과 in ("은전", "징세")
    end

    적합한장수찾기(3) do 장수, 도시
        장수.태수효과 == 도시.군량시설
    end

    (후보군, 장수풀)
end # function nominate_viceroys

function 크기순으로(x::도시타입, y::도시타입)
    도시크기 = ["초소", "소", "중", "대", "초대"]
    indexin([x.크기], 도시크기) > indexin([y.크기], 도시크기)
end # function 크기순으로

function 계보순으로(x::장수타입, y::장수타입)
    모든계보 = split("""
난세간웅의 패
낭고중달의 패
대현량사의 패
군신운장의 패
동래자의의 패
임협원직의 패
패왕본초의 패
백언소후의 패
벽안자염의 패
등후사재의 패
상산자룡의 패
영웅문대의 패
봉추사원의 패
단명백부의 패
미주공근의 패
노장한승의 패
용장익덕의 패
만족맹기의 패
마왕패도의 패
칠금만왕의 패
황숙현덕의 패
문소황후의 패
와룡공명의 패
문명황후의 패
비장봉선의 패
발탁무장의 패
풍운아만의 패
태조고제의 패
패왕항우의 패
난세여걸의 패
    """)
    indexin([x.계보], 모든계보) > indexin([y.계보], 모든계보)
end # function 계보순으로

function 로드(filename)
    장수들 = get_generals(filename)
    도시들 = get_cities(filename)
    (장수들, 도시들)
end # function 로드

function 은전용_태수찾기(크기순_점령한_도시들, 등용한_장수들)
    @info 은전용_태수찾기
    (후보군, 장수풀) = nominate_viceroys(크기순_점령한_도시들, 등용한_장수들)
    이름순_임명할_도시들 = sort(크기순_점령한_도시들, by=도시->도시.이름)

    for 도시 in 이름순_임명할_도시들
        태수 = 후보군[도시.이름]
        if 태수 isa Nothing
            @info (도시.이름, 도시.은전시설)
        else
            단계 = 장수풀[태수.이름]
            @info (도시.이름, 태수.이름, 도시.은전시설, 단계, 태수)
        end
    end
end # function 은전용_태수_찾아주라

function 장수찾기(조건, 등용한_장수들)
    @info 장수찾기
    for 장수 in filter(조건, 등용한_장수들)
        @info 장수
    end
end

점령한(도시) = 도시.점령여부
등용한(장수) = 장수.등용여부


# filename = "조조전온라인 태수정리 made by BJ비비앙.xlsx"
filename = normpath(@__DIR__, "jojo.xlsx")
(장수들, 도시들) = 로드(filename)

크기순_점령한_도시들 = sort(filter(점령한, 도시들), lt=크기순으로)
등용한_장수들 = filter(등용한, 장수들)
등용안한_장수들 = sort(filter(!등용한, 장수들), lt=계보순으로)


은전용_태수찾기(크기순_점령한_도시들, 등용한_장수들)
장수찾기(등용안한_장수들) do 장수
    장수.태수효과 == "시장"
end
