// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF1YVSZ
// Restricted predicate has range [0, 7].
ldff1sb z9.d, p8/z, [x24, z27.d, uxtw]
// CHECK: error: invalid operand
