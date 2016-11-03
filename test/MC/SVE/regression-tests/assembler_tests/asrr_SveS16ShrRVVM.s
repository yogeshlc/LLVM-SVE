// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrr    z0.h, p0/m, z0.h, z0.h  // 00000100-01010100-10000000-00000000
// CHECK: asrr    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10000000-00000000
ASRR    Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01010100-10000000-00000000
// CHECK: asrr    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10000000-00000000
asrr    z21.h, p5/m, z21.h, z10.h  // 00000100-01010100-10010101-01010101
// CHECK: asrr    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10010101-01010101
ASRR    Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01010100-10010101-01010101
// CHECK: asrr    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10010101-01010101
asrr    z31.h, p7/m, z31.h, z31.h  // 00000100-01010100-10011111-11111111
// CHECK: asrr    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10011111-11111111
ASRR    Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01010100-10011111-11111111
// CHECK: asrr    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10011111-11111111
asrr    z23.h, p3/m, z23.h, z13.h  // 00000100-01010100-10001101-10110111
// CHECK: asrr    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10001101-10110111
ASRR    Z23.H, P3/M, Z23.H, Z13.H  // 00000100-01010100-10001101-10110111
// CHECK: asrr    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x54,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010100-10001101-10110111
