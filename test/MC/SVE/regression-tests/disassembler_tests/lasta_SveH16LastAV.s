# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x62,0x05
# CHECK: lasta   h0, p0, z0.h // encoding: [0x00,0x80,0x62,0x05]
# CHECK-ERROR-NOT: lasta   h0, p0, z0.h 
0xb7,0x8d,0x62,0x05
# CHECK: lasta   h23, p3, z13.h // encoding: [0xb7,0x8d,0x62,0x05]
# CHECK-ERROR-NOT: lasta   h23, p3, z13.h 
0xff,0x9f,0x62,0x05
# CHECK: lasta   h31, p7, z31.h // encoding: [0xff,0x9f,0x62,0x05]
# CHECK-ERROR-NOT: lasta   h31, p7, z31.h 
0x55,0x95,0x62,0x05
# CHECK: lasta   h21, p5, z10.h // encoding: [0x55,0x95,0x62,0x05]
# CHECK-ERROR-NOT: lasta   h21, p5, z10.h 
