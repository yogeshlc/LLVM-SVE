// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGEVWZ
// Restricted predicate has range [0, 7].
cmphs p2.h, p8/z, z30.h, z23.d
// CHECK: error: invalid operand
