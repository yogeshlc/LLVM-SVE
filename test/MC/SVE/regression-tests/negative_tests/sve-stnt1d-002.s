// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStoreNT8SIZ
// Restricted predicate has range [0, 7].
stnt1d z5.d, p8, [x19, #0, MUL VL]
// CHECK: error: invalid operand
