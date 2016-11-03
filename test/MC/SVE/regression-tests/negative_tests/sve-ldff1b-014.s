// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1b z21.b, p8/z, [x28, x0]
// CHECK: error: invalid operand
