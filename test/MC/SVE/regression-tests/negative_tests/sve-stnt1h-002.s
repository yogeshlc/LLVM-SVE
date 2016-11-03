// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStoreNT2SIZ
// Restricted predicate has range [0, 7].
stnt1h z13.h, p8, [x19, #11, MUL VL]
// CHECK: error: invalid operand
