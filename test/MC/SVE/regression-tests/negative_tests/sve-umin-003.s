// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MinVVM
// Restricted predicate has range [0, 7].
umin z6.h, p8/m, z6.h, z27.h
// CHECK: error: invalid operand
