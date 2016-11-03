// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNF2SIZ
// Restricted predicate has range [0, 7].
ldnf1h z0.h, p8/z, [x2, #12, MUL VL]
// CHECK: error: invalid operand
