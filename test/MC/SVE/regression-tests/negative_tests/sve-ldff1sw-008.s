// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4YSVZ
// Restricted predicate has range [0, 7].
ldff1sw z3.d, p8/z, [x7, z23.d, uxtw #2]
// CHECK: error: invalid operand
