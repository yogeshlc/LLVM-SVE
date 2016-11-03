// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store2XSVZ
// Restricted predicate has range [0, 7].
st1h z27.d, p8, [x29, z20.d, sxtw #1]
// CHECK: error: invalid operand
