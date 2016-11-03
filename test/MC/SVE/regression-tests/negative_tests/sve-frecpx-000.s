// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64RecpXVM
// Restricted predicate has range [0, 7].
frecpx z18.d, p8/m, z7.d
// CHECK: error: invalid operand
