// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MinVIM
// Restricted predicate has range [0, 7].
fmin z30.d, p8/m, z30.d, #0.0
// CHECK: error: invalid operand
