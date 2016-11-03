// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmphs p3.h, p8/z, z24.h, #0
// CHECK: error: invalid operand
