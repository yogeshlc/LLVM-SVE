// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CompressVV
// Restricted predicate has range [0, 7].
compact z29.s, p8, z18.s
// CHECK: error: invalid operand
