// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad8SIZ
// Restricted predicate has range [0, 7].
ld1d z25.d, p8/z, [x22, #7, MUL VL]
// CHECK: error: invalid operand
