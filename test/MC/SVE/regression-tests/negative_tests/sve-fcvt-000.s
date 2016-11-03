// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64ExtndFVM
// Restricted predicate has range [0, 7].
fcvt z26.d, p8/m, z21.s
// CHECK: error: invalid operand
