// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8XSVZ
// Restricted predicate has range [0, 7].
ld1d z20.d, p8/z, [x17, z21.d, sxtw #3]
// CHECK: error: invalid operand
