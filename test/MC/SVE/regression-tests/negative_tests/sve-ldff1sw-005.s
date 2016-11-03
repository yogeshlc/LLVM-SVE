// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4VSZ
// Restricted predicate has range [0, 7].
ldff1sw z4.d, p8/z, [x23, z18.d]
// CHECK: error: invalid operand
