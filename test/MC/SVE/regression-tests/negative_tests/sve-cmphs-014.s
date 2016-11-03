// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmphs p1.b, p8/z, z5.b, #0
// CHECK: error: invalid operand
