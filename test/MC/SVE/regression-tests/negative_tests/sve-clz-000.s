// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ClzVM
// Restricted predicate has range [0, 7].
clz z30.h, p8/m, z1.h
// CHECK: error: invalid operand
