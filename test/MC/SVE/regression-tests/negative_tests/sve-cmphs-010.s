// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmphs p10.d, p8/z, z10.d, #0
// CHECK: error: invalid operand
