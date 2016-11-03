// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Extnd12VM
// Restricted predicate has range [0, 7].
uxtb z27.h, p8/m, z29.h
// CHECK: error: invalid operand
