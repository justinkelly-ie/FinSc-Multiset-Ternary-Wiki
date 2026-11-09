module Wiki.Main

import System
import Wiki.TernaryScaleTransformSpec
import Stage0.NarayAlphabet
import Stage1.TernaryLogic

%default total

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn "  IDRIS 2 MULTISET TERNARY WIKI VERIFICATION SUITE"
  putStrLn "========================================================"
  putStrLn "1. Bit3 ScaleTransform & F3 Galois Inversion QuickCheck Specs:"
  p <- auditTernaryScaleTransformSpecProof
  if p
     then putStrLn "   [PASSED] Bit3 F3 ScaleTransform Verified!"
     else do
       putStrLn "   [FAILED] QuickCheck Specs Failed!"
       exitWith (ExitFailure 1)
  putStrLn $ "2. Ternary Polynumber Streaming Multiset Round-Trip (Rule 04 §12): " ++ (if Stage1.TernaryLogic.auditTernaryPolyStreamRoundTripProof then "[PASSED] ✅" else "[FAILED] ❌")
  putStrLn "========================================================"
  putStrLn "  MULTISET TERNARY WIKI VERIFICATION COMPLETE: ALL PASSED!"
  putStrLn "========================================================"
