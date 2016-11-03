// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CStoreNT1LSSZ
// Restricted predicate has range [0, 7].
stnt1b z21.b, p8, [x12, x25]
// CHECK: error: invalid operand
