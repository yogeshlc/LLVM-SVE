// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8XVSZ
// Restricted predicate has range [0, 7].
st1d z24.d, p8, [x6, z15.d, sxtw]
// CHECK: error: invalid operand
