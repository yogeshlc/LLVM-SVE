// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF4SIZ
// Restricted predicate has range [0, 7].
ldnf1w z19.d, p8/z, [x26, #11, MUL VL]
// CHECK: error: invalid operand
