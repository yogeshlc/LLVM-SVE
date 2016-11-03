// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4SI
// Restricted predicate has range [0, 7].
prfw pstl2keep, p8, [x10, #7, MUL VL]
// CHECK: error: invalid operand
