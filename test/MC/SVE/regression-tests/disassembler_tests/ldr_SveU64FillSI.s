# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x5f,0xbf,0x85
# CHECK: ldr     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0x85]
# CHECK-ERROR-NOT: ldr     z31, [sp, #-1, mul vl] 
0x00,0x40,0x80,0x85
# CHECK: ldr     z0, [x0] // encoding: [0x00,0x40,0x80,0x85]
# CHECK-ERROR-NOT: ldr     z0, [x0] 
0x55,0x55,0x95,0x85
# CHECK: ldr     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0x85]
# CHECK-ERROR-NOT: ldr     z21, [x10, #173, mul vl] 
0xb7,0x4d,0x88,0x85
# CHECK: ldr     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0x85]
# CHECK-ERROR-NOT: ldr     z23, [x13, #67, mul vl] 
