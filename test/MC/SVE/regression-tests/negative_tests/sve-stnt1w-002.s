// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStoreNT4SIZ
// Restricted predicate has range [0, 7].
stnt1w z15.s, p8, [x1, #9, MUL VL]
// CHECK: error: invalid operand
