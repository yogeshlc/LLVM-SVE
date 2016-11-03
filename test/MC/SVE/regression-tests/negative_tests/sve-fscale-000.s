// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64ScaleVVM
// Restricted predicate has range [0, 7].
fscale z13.d, p8/m, z13.d, z9.d
// CHECK: error: invalid operand
