// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNT2LSSZ
// Restricted predicate has range [0, 7].
ldnt1h z30.h, p8/z, [x2, x20, lsl #1]
// CHECK: error: invalid operand
