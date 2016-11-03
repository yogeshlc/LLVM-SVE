// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Prefetch2SI
// Restricted predicate has range [0, 7].
prfh pldl1keep, p8, [x20, #19, MUL VL]
// CHECK: error: invalid operand
