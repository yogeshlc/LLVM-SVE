# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xdf,0xc5
# CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xff,0xdf,0xc5]
# CHECK-ERROR-NOT: ldff1d  {z31.d}, p7/z, [sp, z31.d] 
0xb7,0xed,0xc8,0xc5
# CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xed,0xc8,0xc5]
# CHECK-ERROR-NOT: ldff1d  {z23.d}, p3/z, [x13, z8.d] 
0x55,0xf5,0xd5,0xc5
# CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xf5,0xd5,0xc5]
# CHECK-ERROR-NOT: ldff1d  {z21.d}, p5/z, [x10, z21.d] 
0x00,0xe0,0xc0,0xc5
# CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xe0,0xc0,0xc5]
# CHECK-ERROR-NOT: ldff1d  {z0.d}, p0/z, [x0, z0.d] 
