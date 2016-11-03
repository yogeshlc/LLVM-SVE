# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x5a,0x04
# CHECK: cnt     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5a,0x04]
# CHECK-ERROR-NOT: cnt     z21.h, p5/m, z10.h 
0xff,0xbf,0x5a,0x04
# CHECK: cnt     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5a,0x04]
# CHECK-ERROR-NOT: cnt     z31.h, p7/m, z31.h 
0xb7,0xad,0x5a,0x04
# CHECK: cnt     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5a,0x04]
# CHECK-ERROR-NOT: cnt     z23.h, p3/m, z13.h 
0x00,0xa0,0x5a,0x04
# CHECK: cnt     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5a,0x04]
# CHECK-ERROR-NOT: cnt     z0.h, p0/m, z0.h 
