# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0x2f,0x04
# CHECK: uqdecb  wzr, all, mul #16 // encoding: [0xff,0xff,0x2f,0x04]
# CHECK-ERROR-NOT: uqdecb  wzr, all, mul #16 
0xb7,0xfd,0x28,0x04
# CHECK: uqdecb  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x28,0x04]
# CHECK-ERROR-NOT: uqdecb  w23, vl256, mul #9 
0x00,0xfc,0x20,0x04
# CHECK: uqdecb  w0, pow2 // encoding: [0x00,0xfc,0x20,0x04]
# CHECK-ERROR-NOT: uqdecb  w0, pow2 
0x55,0xfd,0x25,0x04
# CHECK: uqdecb  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x25,0x04]
# CHECK-ERROR-NOT: uqdecb  w21, vl32, mul #6 
