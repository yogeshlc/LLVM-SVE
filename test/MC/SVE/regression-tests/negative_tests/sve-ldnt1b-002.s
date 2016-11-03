// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoadNT1SIZ
// Restricted predicate has range [0, 7].
ldnt1b z0.b, p8/z, [x24, #3, MUL VL]
// CHECK: error: invalid operand
