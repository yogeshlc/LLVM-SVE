# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xfd,0x65,0x04
# CHECK: uqdech  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x65,0x04]
# CHECK-ERROR-NOT: uqdech  w21, vl32, mul #6 
0x00,0xfc,0x60,0x04
# CHECK: uqdech  w0, pow2 // encoding: [0x00,0xfc,0x60,0x04]
# CHECK-ERROR-NOT: uqdech  w0, pow2 
0xb7,0xfd,0x68,0x04
# CHECK: uqdech  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x68,0x04]
# CHECK-ERROR-NOT: uqdech  w23, vl256, mul #9 
0xff,0xff,0x6f,0x04
# CHECK: uqdech  wzr, all, mul #16 // encoding: [0xff,0xff,0x6f,0x04]
# CHECK-ERROR-NOT: uqdech  wzr, all, mul #16 
