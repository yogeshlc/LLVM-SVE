// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNT2SIZ
// Restricted predicate has range [0, 7].
ldnt1h z21.h, p8/z, [x27, #14, MUL VL]
// CHECK: error: invalid operand
