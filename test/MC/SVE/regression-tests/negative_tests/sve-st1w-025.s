// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4YVSZ
// Restricted predicate has range [0, 7].
st1w z18.d, p8, [x6, z23.d, uxtw]
// CHECK: error: invalid operand
