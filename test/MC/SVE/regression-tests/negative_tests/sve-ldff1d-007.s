// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF8XVSZ
// Restricted predicate has range [0, 7].
ldff1d z19.d, p8/z, [x11, z17.d, sxtw]
// CHECK: error: invalid operand
