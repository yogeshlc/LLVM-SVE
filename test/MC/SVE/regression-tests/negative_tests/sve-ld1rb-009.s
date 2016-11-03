// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rb z21.b, p8/z, [x1, #19]
// CHECK: error: invalid operand
