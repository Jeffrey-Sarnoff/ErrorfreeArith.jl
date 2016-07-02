## ErrorfreeArithmetic
errorfree transformations and other arithmetic mappings of like accuracy
```ruby
                                                       Jeffrey Sarnoff © 2016-Mar-22 in New York City
                                                                         2016-Jun-25 at v"0.1.0"
```
#### Nomenclature

The name of each exported function begins with a thrice lettered acronym.  This prefix classifies the accuracy of the evaluand into one of two sorts:  
    
    sortal                | prefix | acronym                        | semantics (!rigourous review needed!)      |
    ----------------------|--------|--------------------------------|------------------------------------------|
    evaluates errorfree   |  eft   | `E`rror`F`ree `T`ransformation | RoundNearest using 24/53 extra bits        |
    evaluates accurately  |  acc   | `ACC`urate rounding          | \|ans-ideal\|/ans <= 2 \* eps(ans)  |
    

#### Exports
```julia
  eftIncr, eftDecr, eftSqr,                   # 1 arg  
  accSqrt, accSqrtForSign, accInv,  
  eftAdd, eftSub, eftMul, accDiv,             # 2 args  
  eftAddGTE, eftSubGTE, accDivForSign,
  eftAddGTE, eftAddGTEas2, eftAdd, eftAddAs2, # 3 args  
  eftMul, eftMulAs3, eftMulAs2,           
  eftFMA, eftFMA, eftFMAas2, eftFMSas2,  
  eftAddGTE, eftAddGTEas3, eftAdd, eftAddAs3  # 4 args
```

#### Use
```julia
using ErrorfreeArithmetic

hiPart, loPart  =  eftAdd(   12345.0f0  , 0.12345f0       ) 
showall( (hiPart,loPart) ) # 12345.123f0, 0.00040312856f0

hiPart, loPart  =  eftAdd(   12345.0    , 0.12345         ) 
showall( (hiPart,loPart) ) # 12345.12345, 8.614775559578902e-13

loPart == Float64((big(12345.0)+big(0.12345)) - big(hiPart)) # true


```
###Notes

Most of tese functions will accept variables _v_ that are a subtype of Real for which `convert`(`Float64`, _v_ ) is defined  
(The functions of four arguments presuppose uniformly typed built-in AbstractFloats).
