// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CondXBSV
// Restricted predicate has range [0, 7].
clastb w2, p8, w2, z19.h
// CHECK: error: invalid operand
