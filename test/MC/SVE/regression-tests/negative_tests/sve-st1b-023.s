// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store1VSZ
// Restricted predicate has range [0, 7].
st1b z12.d, p8, [x14, z6.d]
// CHECK: error: invalid operand
