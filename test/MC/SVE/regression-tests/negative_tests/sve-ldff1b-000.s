// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1b z17.h, p8/z, [x6, x11]
// CHECK: error: invalid operand
