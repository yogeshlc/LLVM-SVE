// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup8SIZ
// Restricted predicate has range [0, 7].
ld1rd z26.d, p8/z, [x7, #18]
// CHECK: error: invalid operand
