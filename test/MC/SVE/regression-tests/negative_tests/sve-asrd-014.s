// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrDVIM
// Restricted predicate has range [0, 7].
asrd z21.b, p8/m, z21.b, #1
// CHECK: error: invalid operand
