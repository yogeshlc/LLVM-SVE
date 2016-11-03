// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadNF4SIZ
// Restricted predicate has range [0, 7].
ldnf1sw z4.d, p8/z, [x22, #7, MUL VL]
// CHECK: error: invalid operand
