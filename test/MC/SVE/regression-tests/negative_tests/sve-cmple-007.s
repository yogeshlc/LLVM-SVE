// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLEVWZ
// Restricted predicate has range [0, 7].
cmple p0.s, p8/z, z14.s, z14.d
// CHECK: error: invalid operand
