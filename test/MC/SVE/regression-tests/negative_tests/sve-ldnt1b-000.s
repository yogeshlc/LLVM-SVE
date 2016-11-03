// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoadNT1LSSZ
// Restricted predicate has range [0, 7].
ldnt1b z29.b, p8/z, [x1, x7]
// CHECK: error: invalid operand
