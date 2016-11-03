# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x1a,0x04
# CHECK: cnt     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x1a,0x04]
# CHECK-ERROR-NOT: cnt     z21.b, p5/m, z10.b 
0xff,0xbf,0x1a,0x04
# CHECK: cnt     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x1a,0x04]
# CHECK-ERROR-NOT: cnt     z31.b, p7/m, z31.b 
0x00,0xa0,0x1a,0x04
# CHECK: cnt     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x1a,0x04]
# CHECK-ERROR-NOT: cnt     z0.b, p0/m, z0.b 
0xb7,0xad,0x1a,0x04
# CHECK: cnt     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x1a,0x04]
# CHECK-ERROR-NOT: cnt     z23.b, p3/m, z13.b 
