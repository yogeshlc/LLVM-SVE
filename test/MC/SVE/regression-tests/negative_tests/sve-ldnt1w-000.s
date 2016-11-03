// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadNT4LSSZ
// Restricted predicate has range [0, 7].
ldnt1w z19.s, p8/z, [x13, x24, lsl #2]
// CHECK: error: invalid operand
