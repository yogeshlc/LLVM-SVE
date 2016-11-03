// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadNT4SIZ
// Restricted predicate has range [0, 7].
ldnt1w z4.s, p8/z, [x27, #11, MUL VL]
// CHECK: error: invalid operand
