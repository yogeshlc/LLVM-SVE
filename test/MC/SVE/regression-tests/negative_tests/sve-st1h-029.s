// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store2YSVZ
// Restricted predicate has range [0, 7].
st1h z7.d, p8, [x0, z4.d, uxtw #1]
// CHECK: error: invalid operand
