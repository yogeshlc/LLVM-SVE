# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x0d,0xc8,0x04
# CHECK: smax    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xc8,0x04]
# CHECK-ERROR-NOT: smax    z23.d, p3/m, z23.d, z13.d 
0xff,0x1f,0xc8,0x04
# CHECK: smax    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xc8,0x04]
# CHECK-ERROR-NOT: smax    z31.d, p7/m, z31.d, z31.d 
0x55,0x15,0xc8,0x04
# CHECK: smax    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xc8,0x04]
# CHECK-ERROR-NOT: smax    z21.d, p5/m, z21.d, z10.d 
0x00,0x00,0xc8,0x04
# CHECK: smax    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xc8,0x04]
# CHECK-ERROR-NOT: smax    z0.d, p0/m, z0.d, z0.d 
