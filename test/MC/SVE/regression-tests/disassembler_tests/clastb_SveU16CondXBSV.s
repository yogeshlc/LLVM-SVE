# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0x71,0x05
# CHECK: clastb  wzr, p7, wzr, z31.h // encoding: [0xff,0xbf,0x71,0x05]
# CHECK-ERROR-NOT: clastb  wzr, p7, wzr, z31.h 
0xb7,0xad,0x71,0x05
# CHECK: clastb  w23, p3, w23, z13.h // encoding: [0xb7,0xad,0x71,0x05]
# CHECK-ERROR-NOT: clastb  w23, p3, w23, z13.h 
0x00,0xa0,0x71,0x05
# CHECK: clastb  w0, p0, w0, z0.h // encoding: [0x00,0xa0,0x71,0x05]
# CHECK-ERROR-NOT: clastb  w0, p0, w0, z0.h 
0x55,0xb5,0x71,0x05
# CHECK: clastb  w21, p5, w21, z10.h // encoding: [0x55,0xb5,0x71,0x05]
# CHECK-ERROR-NOT: clastb  w21, p5, w21, z10.h 
