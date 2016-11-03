// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32RecpXVM
// Restricted predicate has range [0, 7].
frecpx z18.s, p8/m, z2.s
// CHECK: error: invalid operand
