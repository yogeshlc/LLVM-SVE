// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store1VSZ
// Restricted predicate has range [0, 7].
st1b z23.s, p8, [x28, z9.s, uxtw]
// CHECK: error: invalid operand
