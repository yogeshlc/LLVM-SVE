// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FNMSUBVVVM
// Restricted predicate has range [0, 7].
fnmsb z28.d, p8/m, z12.d, z19.d
// CHECK: error: invalid operand
