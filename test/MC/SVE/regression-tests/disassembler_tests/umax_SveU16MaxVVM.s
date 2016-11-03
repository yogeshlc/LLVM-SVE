# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x15,0x49,0x04
# CHECK: umax    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x15,0x49,0x04]
# CHECK-ERROR-NOT: umax    z21.h, p5/m, z21.h, z10.h 
0xff,0x1f,0x49,0x04
# CHECK: umax    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x1f,0x49,0x04]
# CHECK-ERROR-NOT: umax    z31.h, p7/m, z31.h, z31.h 
0x00,0x00,0x49,0x04
# CHECK: umax    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x00,0x49,0x04]
# CHECK-ERROR-NOT: umax    z0.h, p0/m, z0.h, z0.h 
0xb7,0x0d,0x49,0x04
# CHECK: umax    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x0d,0x49,0x04]
# CHECK-ERROR-NOT: umax    z23.h, p3/m, z23.h, z13.h 
