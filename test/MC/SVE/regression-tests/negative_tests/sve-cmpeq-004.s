// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgEQVWZ
// Restricted predicate has range [0, 7].
cmpeq p5.h, p8/z, z10.h, z27.d
// CHECK: error: invalid operand
