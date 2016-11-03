// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4YVSZ
// Restricted predicate has range [0, 7].
ldff1w z18.d, p8/z, [x25, z11.d, uxtw]
// CHECK: error: invalid operand
