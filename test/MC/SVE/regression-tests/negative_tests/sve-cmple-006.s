// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmple p5.s, p8/z, z7.s, #-16
// CHECK: error: invalid operand
