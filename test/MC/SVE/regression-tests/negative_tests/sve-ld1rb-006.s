// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rb z5.d, p8/z, [x10, #30]
// CHECK: error: invalid operand
