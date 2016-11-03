// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGEVWZ
// Restricted predicate has range [0, 7].
cmphs p2.b, p8/z, z8.b, z25.d
// CHECK: error: invalid operand
