# Multiset Ternary ScaleTransform & F3 Field Verification

```idris
module Wiki.TernaryScaleTransformSpec

import Stage0.BoxInt
import Stage1.ScaleTransform
import Stage0.NarayAlphabet
import Stage1.TernaryLogic
import Stage0.OnSeq.FusedStream
import Data.Fuel
import Wiki.Generators
import public QuickCheck

%default total

||| Erased compile-time witness verifying triadic 27-unixel manifest space rank (unixels = 27)
public export
0 TriadicDimensionWitness : (unixels : Nat) -> Type
TriadicDimensionWitness unixels = unixels = 27

||| Static compile-time witness proving triadic rank (27 = 27)
public export
prfTriadic27UnixelDimension : TriadicDimensionWitness 27
prfTriadic27UnixelDimension = Refl

||| Verified triadic state carrying erased 27-unixel dimension witness
public export
record VerifiedTriadicState where
  constructor MkVerifiedTriadicState
  unixelCount : Nat
  0 dimensionPrf : TriadicDimensionWitness unixelCount

||| $O(1)$ allocation deforested triadic unixel stream transducer using fusedHylomorphism
public export covering
fusedTriadicUnixelStream : Fuel -> List (Nat, Nat) -> Nat
fusedTriadicUnixelStream f items =
  fusedHylomorphism f
    (\st => case st of
              [] => Done
              (u1, u2) :: rest => Yield (u1 + u2) rest)
    (\val, acc => val + acc)
    0
    items
```

## QuickCheck Verification Properties

```idris
public export
prop_bit3ScaleTransformBounded : Bit3 -> Bool
prop_bit3ScaleTransformBounded b =
  let i : Integer = scaleTransform b
  in i >= -1 && i <= 1

public export
prop_bit3InvertScaleAdjunction : Bit3 -> Bool
prop_bit3InvertScaleAdjunction b =
  let i : Integer = scaleTransform b
      b' : Bit3 = invertScaleTransform i
  in b' == b

public export
prop_bit3Involution : Bit3 -> Bool
prop_bit3Involution b =
  notBit3 (notBit3 b) == b

public export
prop_bit3AdditiveInverse : Bit3 -> Bool
prop_bit3AdditiveInverse b =
  addBit3 b (notBit3 b) == Bit3Zero

public export
auditTernaryScaleTransformSpecProof : IO Bool
auditTernaryScaleTransformSpecProof = do
  let r1 = qc prop_bit3ScaleTransformBounded
  let r2 = qc prop_bit3InvertScaleAdjunction
  let r3 = qc prop_bit3Involution
  let r4 = qc prop_bit3AdditiveInverse
  let streamSum = fusedTriadicUnixelStream (limit 100) [(13, 14), (0, 0)]
  pure (r1.pass == Just True && r2.pass == Just True && r3.pass == Just True && r4.pass == Just True && streamSum == 27)
```
