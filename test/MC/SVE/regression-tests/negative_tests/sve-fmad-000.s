// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FMADDVVVM
// Restricted predicate has range [0, 7].
fmad z19.d, p8/m, z21.d, z24.d
// CHECK: error: invalid operand
