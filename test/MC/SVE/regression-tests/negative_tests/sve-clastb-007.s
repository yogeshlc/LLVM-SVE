// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH16CondXBSV
// Source and Destination Registers must match
clastb h6, p0, h7, z27.h
// CHECK: error: operand must match destination register
