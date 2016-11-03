# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0x68,0xe4
# CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x68,0xe4]
# CHECK-ERROR-NOT: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8] 
0x00,0x60,0x60,0xe4
# CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x60,0xe4]
# CHECK-ERROR-NOT: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0] 
0x25,0x6e,0x70,0xe4
# CHECK: st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x70,0xe4]
# CHECK-ERROR-NOT: st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16] 
0x55,0x75,0x75,0xe4
# CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x75,0xe4]
# CHECK-ERROR-NOT: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21] 
