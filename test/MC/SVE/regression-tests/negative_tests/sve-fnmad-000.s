// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FNMADDVVVM
// Restricted predicate has range [0, 7].
fnmad z13.d, p8/m, z29.d, z13.d
// CHECK: error: invalid operand
