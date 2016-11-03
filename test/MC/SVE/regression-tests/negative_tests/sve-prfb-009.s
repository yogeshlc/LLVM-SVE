// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch1XSV
// Restricted predicate has range [0, 7].
prfb pldl2strm, p8, [x9, z12.d, sxtw]
// CHECK: error: invalid operand
