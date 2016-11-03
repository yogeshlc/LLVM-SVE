// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ClsVM
// Restricted predicate has range [0, 7].
cls z30.h, p8/m, z21.h
// CHECK: error: invalid operand
