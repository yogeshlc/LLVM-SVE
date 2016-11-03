// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LastBV
// Restricted predicate has range [0, 7].
lastb w16, p8, z12.s
// CHECK: error: invalid operand
