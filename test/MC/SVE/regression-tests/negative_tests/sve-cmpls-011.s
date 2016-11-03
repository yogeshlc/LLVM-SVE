// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgLEVIZ
// Restricted predicate has range [0, 7].
cmpls p13.b, p8/z, z22.b, #0
// CHECK: error: invalid operand
