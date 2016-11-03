# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0x28,0xa4
# CHECK: ldff1b  {z23.h}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0x28,0xa4]
# CHECK-ERROR-NOT: ldff1b  {z23.h}, p3/z, [x13, x8] 
0xff,0x7f,0x3f,0xa4
# CHECK: ldff1b  {z31.h}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0x3f,0xa4]
# CHECK-ERROR-NOT: ldff1b  {z31.h}, p7/z, [sp, xzr] 
0x55,0x75,0x35,0xa4
# CHECK: ldff1b  {z21.h}, p5/z, [x10, x21] // encoding: [0x55,0x75,0x35,0xa4]
# CHECK-ERROR-NOT: ldff1b  {z21.h}, p5/z, [x10, x21] 
0x00,0x60,0x20,0xa4
# CHECK: ldff1b  {z0.h}, p0/z, [x0, x0] // encoding: [0x00,0x60,0x20,0xa4]
# CHECK-ERROR-NOT: ldff1b  {z0.h}, p0/z, [x0, x0] 
