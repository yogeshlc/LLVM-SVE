// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AddReduceV
// Restricted predicate has range [0, 7].
uaddv d11, p8, z9.s
// CHECK: error: invalid operand
