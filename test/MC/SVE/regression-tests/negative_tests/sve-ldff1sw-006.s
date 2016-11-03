// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4XSVZ
// Restricted predicate has range [0, 7].
ldff1sw z21.d, p8/z, [x6, z15.d, sxtw #2]
// CHECK: error: invalid operand
