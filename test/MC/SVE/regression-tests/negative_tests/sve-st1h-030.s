// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store2YVSZ
// Restricted predicate has range [0, 7].
st1h z22.d, p8, [x12, z9.d, uxtw]
// CHECK: error: invalid operand
