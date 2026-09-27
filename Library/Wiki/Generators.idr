module Wiki.Generators

import public QuickCheck
import Core.NarayAlphabet
import Stage0.BoxInt
import Stage0.BoxInt

%default total

public export
natToBit3 : Nat -> Bit3
natToBit3 Z = Bit3MinusOne
natToBit3 (S Z) = Bit3Zero
natToBit3 (S (S _)) = Bit3PlusOne

public export
Arbitrary Bit3 where
  arbitrary = map natToBit3 arbitrary

  coarbitrary Bit3MinusOne gen = coarbitrary (the Nat 0) gen
  coarbitrary Bit3Zero gen     = coarbitrary (the Nat 1) gen
  coarbitrary Bit3PlusOne gen  = coarbitrary (the Nat 2) gen
