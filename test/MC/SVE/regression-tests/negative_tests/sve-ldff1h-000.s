// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadFF2LSSZ
// Restricted predicate has range [0, 7].
ldff1h z3.h, p8/z, [x28, x25, lsl #1]
// CHECK: error: invalid operand
