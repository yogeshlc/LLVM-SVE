// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FRIntPVM
// Restricted predicate has range [0, 7].
frintp z9.d, p8/m, z30.d
// CHECK: error: invalid operand
