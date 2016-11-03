// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CompressVV
// Restricted predicate has range [0, 7].
compact z20.d, p8, z20.d
// CHECK: error: invalid operand
