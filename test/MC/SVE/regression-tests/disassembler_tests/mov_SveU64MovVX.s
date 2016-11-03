# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x33,0x7f,0x04
# CHECK: mov     z31.d, z31.d // encoding: [0xff,0x33,0x7f,0x04]
# CHECK-ERROR-NOT: mov     z31.d, z31.d 
0x00,0x30,0x60,0x04
# CHECK: mov     z0.d, z0.d // encoding: [0x00,0x30,0x60,0x04]
# CHECK-ERROR-NOT: mov     z0.d, z0.d 
