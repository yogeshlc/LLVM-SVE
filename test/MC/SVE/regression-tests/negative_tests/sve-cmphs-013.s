// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmphs p5.d, p8/z, z14.d, z20.d
// CHECK: error: invalid operand
