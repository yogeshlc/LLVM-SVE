// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8LastBV
// Restricted predicate has range [0, 7].
lastb w14, p8, z25.b
// CHECK: error: invalid operand
