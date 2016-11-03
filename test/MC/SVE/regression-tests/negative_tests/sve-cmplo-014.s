// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplo p2.b, p8/z, z28.b, z26.d
// CHECK: error: invalid operand
