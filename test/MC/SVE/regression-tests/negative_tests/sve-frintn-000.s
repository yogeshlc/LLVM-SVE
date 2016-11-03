// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FRIntNVM
// Restricted predicate has range [0, 7].
frintn z29.d, p8/m, z23.d
// CHECK: error: invalid operand
