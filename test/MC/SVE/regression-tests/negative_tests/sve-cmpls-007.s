// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLEVWZ
// Restricted predicate has range [0, 7].
cmpls p5.s, p8/z, z15.s, z26.d
// CHECK: error: invalid operand
