// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AbdVVM
// Restricted predicate has range [0, 7].
uabd z30.h, p8/m, z30.h, z17.h
// CHECK: error: invalid operand
