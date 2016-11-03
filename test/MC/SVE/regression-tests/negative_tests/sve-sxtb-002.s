// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Extnd18VM
// Restricted predicate has range [0, 7].
sxtb z7.d, p8/m, z26.d
// CHECK: error: invalid operand
