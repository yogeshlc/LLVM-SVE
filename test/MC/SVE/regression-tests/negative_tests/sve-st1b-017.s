// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore1SIZ
// Restricted predicate has range [0, 7].
st1b z15.d, p8, [x30, #9, MUL VL]
// CHECK: error: invalid operand
