// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16VCondXAVV
// Restricted predicate has range [0, 7].
clasta z18.h, p8, z18.h, z20.h
// CHECK: error: invalid operand
