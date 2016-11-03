// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch8SI
// Restricted predicate has range [0, 7].
prfd pstl2keep, p8, [x28, #45, MUL VL]
// CHECK: error: invalid operand
