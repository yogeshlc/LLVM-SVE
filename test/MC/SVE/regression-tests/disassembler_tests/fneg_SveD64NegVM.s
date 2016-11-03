# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xdd,0x04
# CHECK: fneg    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xdd,0x04]
# CHECK-ERROR-NOT: fneg    z31.d, p7/m, z31.d 
0x00,0xa0,0xdd,0x04
# CHECK: fneg    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xdd,0x04]
# CHECK-ERROR-NOT: fneg    z0.d, p0/m, z0.d 
0x55,0xb5,0xdd,0x04
# CHECK: fneg    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xdd,0x04]
# CHECK-ERROR-NOT: fneg    z21.d, p5/m, z10.d 
0xb7,0xad,0xdd,0x04
# CHECK: fneg    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xdd,0x04]
# CHECK-ERROR-NOT: fneg    z23.d, p3/m, z13.d 
