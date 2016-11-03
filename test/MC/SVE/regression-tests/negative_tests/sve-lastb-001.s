// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64LastBV
// Restricted predicate has range [0, 7].
lastb d4, p8, z4.d
// CHECK: error: invalid operand
