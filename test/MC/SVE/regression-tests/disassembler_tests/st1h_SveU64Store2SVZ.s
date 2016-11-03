# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0xa0,0xe4
# CHECK: st1h    {z0.d}, p0, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0xa0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.d}, p0, [x0, z0.d, lsl #1] 
0x55,0xb5,0xb5,0xe4
# CHECK: st1h    {z21.d}, p5, [x10, z21.d, lsl #1] // encoding: [0x55,0xb5,0xb5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.d}, p5, [x10, z21.d, lsl #1] 
0xff,0xbf,0xbf,0xe4
# CHECK: st1h    {z31.d}, p7, [sp, z31.d, lsl #1] // encoding: [0xff,0xbf,0xbf,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.d}, p7, [sp, z31.d, lsl #1] 
0xb7,0xad,0xa8,0xe4
# CHECK: st1h    {z23.d}, p3, [x13, z8.d, lsl #1] // encoding: [0xb7,0xad,0xa8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.d}, p3, [x13, z8.d, lsl #1] 
