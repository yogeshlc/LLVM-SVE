# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x4e,0x50,0xe4
# CHECK: st1b    {z5.s}, p3, [x17, x16] // encoding: [0x25,0x4e,0x50,0xe4]
# CHECK-ERROR-NOT: st1b    {z5.s}, p3, [x17, x16] 
0x00,0x40,0x40,0xe4
# CHECK: st1b    {z0.s}, p0, [x0, x0] // encoding: [0x00,0x40,0x40,0xe4]
# CHECK-ERROR-NOT: st1b    {z0.s}, p0, [x0, x0] 
0x55,0x55,0x55,0xe4
# CHECK: st1b    {z21.s}, p5, [x10, x21] // encoding: [0x55,0x55,0x55,0xe4]
# CHECK-ERROR-NOT: st1b    {z21.s}, p5, [x10, x21] 
0xb7,0x4d,0x48,0xe4
# CHECK: st1b    {z23.s}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xe4]
# CHECK-ERROR-NOT: st1b    {z23.s}, p3, [x13, x8] 
