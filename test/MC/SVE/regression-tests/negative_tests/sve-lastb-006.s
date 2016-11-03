// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LastBV
// Restricted predicate has range [0, 7].
lastb x0, p8, z17.d
// CHECK: error: invalid operand
