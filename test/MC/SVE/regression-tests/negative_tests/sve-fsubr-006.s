// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubRVVM
// Restricted predicate has range [0, 7].
fsubr z19.s, p8/m, z19.s, z6.s
// CHECK: error: invalid operand
