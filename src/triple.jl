function eftAddGTE{T<:StdFloat}(a::T,b::T,c::T)
    s,t = eftAddGTE(b, c)
    x,u = eftAddGTE(a, s)
    y,z = eftAddGTE(u, t)
    x,y = eftAddGTE(x, y)
    x,y,z
end

function eftAddGTEas2{T<:StdFloat}(a::T,b::T,c::T)
    s,t = eftAddGTE(b, c)
    x,u = eftAddGTE(a, s)
    y   = u+t
    x,y = eftAddGTE(x, y)
    x,y
end

function eftAdd{T<:StdFloat}(a::T,b::T,c::T)
    s,t = eftAdd(b, c)
    x,u = eftAdd(a, s)
    y,z = eftAdd(u, t)
    x,y = eftAddGTE(x, y)
    x,y,z
end

function eftAddAs2{T<:StdFloat}(a::T,b::T,c::T)
    s,t = eftAdd(b, c)
    x,u = eftAdd(a, s)
    y   = u+t
    x,y = eftAddGTE(x, y)
    x,y
end

function eftMul{T<:StdFloat}(a::T, b::T, c::T)
    p,e = eftMul(a,b)
    x,y = eftMul(p,c)
    z,t = eftMul(e,c)
    y,z = eftAdd(y,z)
    x,y = eftAdd(x,y)
    eftAddGTE(x,y,z,t)
end

function eftMulas3{T<:StdFloat}(a::T, b::T, c::T)
    p,e = eftMul(a,b)
    x,y = eftMul(p,c)
    z,t = eftMul(e,c)
    y,z = eftAdd(y,z)
    x,y = eftAdd(x,y)
    eftAddGTEas3(x,y,z,t)
end

function eftMulAs2{T<:StdFloat}(a::T, b::T, c::T)
    p,e = eftMul(a,b)
    x,y = eftMul(p,c)
    z   = e*c
    y,z = eftAdd(y,z)
    x,y = eftAdd(x,y)
    x,y
end


function eftFMA{T<:StdFloat}(a::T, b::T, c::T)
    x = fma(a,b,c)
    u1,u2 = eftMul(a,b)
    a1,a2 = eftAdd(u2,c)
    b1,b2 = eftAdd(u1,a1)
    g = (b1-x)+b2
    y,z = eftAddGTE(g,a2)
    x,y,z
end

function eftFMAas2{T<:StdFloat}(a::T, b::T, c::T)
    x = fma(a,b,c)
    u1,u2 = eftMul(a,b)
    a1,a2 = eftAdd(u2,c)
    b1,b2 = eftAdd(u1,a1)
    g = (b1-x)+b2
    y = g+a2
    x,y
end

function eftFMS{T<:StdFloat}(a::T, b::T, c::T)
    x = fma(a,b,-c)
    u1,u2 = eftMul(a,b)
    a1,a2 = eftSub(u2,c)
    b1,b2 = eftAdd(u1,a1)
    g = (b1-x)+b2
    y,z = eftAddGTE(g,a2)
    x,y,z
end

function eftFMSas2{T<:StdFloat}(a::T, b::T, c::T)
    x = fma(a,b,-c)
    u1,u2 = eftMul(a,b)
    a1,a2 = eftSub(u2,c)
    b1,b2 = eftAdd(u1,a1)
    g = (b1-x)+b2
    y = g+a2
    x,y
end



for fn in (:eftAdd, :eftAddGTE, :eftAddAs2, :eftMul, :eftMulAs2, :eftMulAs4, :eftFMA, :eftFMS, :eftFMAas2, :eftFMSas2)
  @eval begin
    ($fn){T1<:Real,T2<:StdFloat,T3<:StdFloat}(a::T1, b::T2, c::T3) = ($fn)(convert(Float64,a), b, c)
    ($fn){T1<:StdFloat,T2<:Real,T3<:StdFloat}(a::T1, b::T2, c::T3) = ($fn)(a, convert(Float64,b), c)
    ($fn){T1<:StdFloat,T2<:StdFloat,T3<:Real}(a::T1, b::T2, c::T3) = ($fn)(a, b, convert(Float64,c))
    ($fn){T1<:StdFloat,T2<:Real,T3<:Real}(a::T1, b::T2, c::T3) = ($fn)(a, convert(Float64,b), convert(Float64,c))
    ($fn){T1<:Real,T2<:StdFloat,T3<:Real}(a::T1, b::T2, c::T3) = ($fn)(convert(Float64,a), b, convert(Float64,c))
    ($fn){T1<:Real,T2<:Real,T3<:StdFloat}(a::T1, b::T2, c::T3) = ($fn)(convert(Float64,a), convert(Float64,b), c)
    ($fn){T1<:Real,T2<:Real,T3<:Real}(a::T1, b::T2, c::T3) = ($fn)(convert(Float64,a), convert(Float64,b), convert(Float64,c))
  end
end
