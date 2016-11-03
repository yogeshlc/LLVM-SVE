// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmphs p9.s, p8/z, z30.s, z8.s
// CHECK: error: invalid operand
