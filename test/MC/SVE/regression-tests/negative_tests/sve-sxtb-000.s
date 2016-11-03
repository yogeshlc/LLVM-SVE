// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16Extnd12VM
// Restricted predicate has range [0, 7].
sxtb z17.h, p8/m, z4.h
// CHECK: error: invalid operand
