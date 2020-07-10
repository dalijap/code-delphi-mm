# Code examples from Delphi Memory Management for Classic and ARC Compilers Book

[https://igoto.co/DelphiMM](https://igoto.co/DelphiMM)

[https://dalija.prasnikar.info](https://dalija.prasnikar.info)


## Part 1. Memory management basics and terminology

### Chapter 3. Variables and types

+ ### 3.3.1 Wild reference 
  
  Wild.dpr
  
  WildWorking.dpr

+ ### 3.3.2 Dangling reference

  Dangling.dpr

+ ### 3.3.3 Stale reference

  Stale.dpr

+ ### 3.4 Scope and lifetime
  
  Scope1.dpr
   
  Scope2.dpr
   
  Scope3.dpr

### Chapter 4. Classes 

+ ### 4.3.2 Self

  uShip.pas

+ ### 4.3.3 inherited 

  uQuestion.pas

  PrintTest.dpr

+ ### 4.4.1 Static binding

  StaticBinding.dpr

+ ### 4.4.4 Method overriding (Dynamic binding)

  DynamicHidding.dpr

  DynamicOverriding.dpr

+ ### 4.4.8 The differences between overriding, hiding, or doing nothing with a virtual method

  Differences.dpr

+ ### 4.4.9 Method overloading

  Overloading1.dpr

  Overloading2.dpr

+ ### 4.4.10 Class methods

  Classy.dpr


## Part 2. Object instances

### Chapter 5. To be, or not to be 

+ ### 5.1.4 Nil exception

  NilException.dpr

+ ### 5.1.5 How to test for nil

  AssignedCheck.dpr

  NilComparison.dpr

  NilComparisonFunc.dpr

+ ### 5.3.1 A use case for null object

  NullObjectPattern.dpr

+ ### 5.3.2 A case against null object

  TreeNil.dpr

  TreeNullObject.dpr

  TreeNullObjectSingle.dpr

+ ### 5.4 Nullable types

  Following nullable implementation is based on Allen Bauer's blog post "A Nullable Post" https://blog.therealoracleatdelphi.com/2008/09/a-post_18.html

  Nullable.pas

  Weather.dpr


### Chapter 6, 7, 8

...


## Part 3. Manual memory management

...

## Part 4. Automatic Reference Counting

...

## Part 5. Coding patterns

+ ### 17.6 Smart Pointers 

  Smart.dpr + uLifeMgr.pas + uSmartPrt.pas

+ ### 17.7 Lazy

  LazyDeathStar.dpr 

  ReallyLazyDeathStar.dpr

+ ### 17.8 Weak

  WeakMagic.dpr + uZWeak.pas

  SimplerWeakMagic.dpr + uZWeak.pas
  