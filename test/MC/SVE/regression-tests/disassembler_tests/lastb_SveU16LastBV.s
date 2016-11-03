# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0x61,0x05
# CHECK: lastb   wzr, p7, z31.h // encoding: [0xff,0xbf,0x61,0x05]
# CHECK-ERROR-NOT: lastb   wzr, p7, z31.h 
0x00,0xa0,0x61,0x05
# CHECK: lastb   w0, p0, z0.h // encoding: [0x00,0xa0,0x61,0x05]
# CHECK-ERROR-NOT: lastb   w0, p0, z0.h 
0xb7,0xad,0x61,0x05
# CHECK: lastb   w23, p3, z13.h // encoding: [0xb7,0xad,0x61,0x05]
# CHECK-ERROR-NOT: lastb   w23, p3, z13.h 
0x55,0xb5,0x61,0x05
# CHECK: lastb   w21, p5, z10.h // encoding: [0x55,0xb5,0x61,0x05]
# CHECK-ERROR-NOT: lastb   w21, p5, z10.h 
