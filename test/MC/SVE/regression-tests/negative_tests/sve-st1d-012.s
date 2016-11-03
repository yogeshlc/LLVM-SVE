// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8YSVZ
// Restricted predicate has range [0, 7].
st1d z24.d, p8, [x12, z10.d, uxtw #3]
// CHECK: error: invalid operand
