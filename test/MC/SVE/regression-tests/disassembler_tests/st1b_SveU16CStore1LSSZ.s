# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x4e,0x30,0xe4
# CHECK: st1b    {z5.h}, p3, [x17, x16] // encoding: [0x25,0x4e,0x30,0xe4]
# CHECK-ERROR-NOT: st1b    {z5.h}, p3, [x17, x16] 
0xb7,0x4d,0x28,0xe4
# CHECK: st1b    {z23.h}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x28,0xe4]
# CHECK-ERROR-NOT: st1b    {z23.h}, p3, [x13, x8] 
0x00,0x40,0x20,0xe4
# CHECK: st1b    {z0.h}, p0, [x0, x0] // encoding: [0x00,0x40,0x20,0xe4]
# CHECK-ERROR-NOT: st1b    {z0.h}, p0, [x0, x0] 
0x55,0x55,0x35,0xe4
# CHECK: st1b    {z21.h}, p5, [x10, x21] // encoding: [0x55,0x55,0x35,0xe4]
# CHECK-ERROR-NOT: st1b    {z21.h}, p5, [x10, x21] 
