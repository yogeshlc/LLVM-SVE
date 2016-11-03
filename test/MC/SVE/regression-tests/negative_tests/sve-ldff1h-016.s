// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2XVSZ
// Restricted predicate has range [0, 7].
ldff1h z7.d, p8/z, [x20, z21.d, sxtw]
// CHECK: error: invalid operand
