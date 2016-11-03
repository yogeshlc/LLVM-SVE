# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xfd,0xb8,0x04
# CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
# CHECK-ERROR-NOT: uqdecw  x23, vl256, mul #9 
0x55,0xfd,0xb5,0x04
# CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
# CHECK-ERROR-NOT: uqdecw  x21, vl32, mul #6 
0x00,0xfc,0xb0,0x04
# CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
# CHECK-ERROR-NOT: uqdecw  x0, pow2 
0xff,0xff,0xbf,0x04
# CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
# CHECK-ERROR-NOT: uqdecw  xzr, all, mul #16 
