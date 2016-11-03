# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xe1,0x59,0x25
# CHECK: ptrues  p5.h, vl32 // encoding: [0x45,0xe1,0x59,0x25]
# CHECK-ERROR-NOT: ptrues  p5.h, vl32 
0xef,0xe3,0x59,0x25
# CHECK: ptrues  p15.h // encoding: [0xef,0xe3,0x59,0x25]
# CHECK-ERROR-NOT: ptrues  p15.h 
0x00,0xe0,0x59,0x25
# CHECK: ptrues  p0.h, pow2 // encoding: [0x00,0xe0,0x59,0x25]
# CHECK-ERROR-NOT: ptrues  p0.h, pow2 
0xa7,0xe1,0x59,0x25
# CHECK: ptrues  p7.h, vl256 // encoding: [0xa7,0xe1,0x59,0x25]
# CHECK-ERROR-NOT: ptrues  p7.h, vl256 
