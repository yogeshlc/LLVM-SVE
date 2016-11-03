// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmphs p14.s, p8/z, z26.s, #0
// CHECK: error: invalid operand
