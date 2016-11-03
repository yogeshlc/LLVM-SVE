// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8VSZ
// Restricted predicate has range [0, 7].
st1d z28.d, p8, [x18, z1.d]
// CHECK: error: invalid operand
