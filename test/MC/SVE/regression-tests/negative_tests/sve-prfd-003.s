// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch8XSV
// Restricted predicate has range [0, 7].
prfd pldl2strm, p8, [x5, z0.s, sxtw #3]
// CHECK: error: invalid operand
