// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SpliceVV
// Restricted predicate has range [0, 7].
splice z23.b, p8, z23.b, z0.b
// CHECK: error: invalid operand
