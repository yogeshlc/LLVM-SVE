// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrr    z0.d, p0/m, z0.d, z0.d  // 00000100-11010100-10000000-00000000
// CHECK: asrr    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10000000-00000000
ASRR    Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11010100-10000000-00000000
// CHECK: asrr    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10000000-00000000
asrr    z31.d, p7/m, z31.d, z31.d  // 00000100-11010100-10011111-11111111
// CHECK: asrr    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10011111-11111111
ASRR    Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11010100-10011111-11111111
// CHECK: asrr    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10011111-11111111
asrr    z21.d, p5/m, z21.d, z10.d  // 00000100-11010100-10010101-01010101
// CHECK: asrr    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10010101-01010101
ASRR    Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11010100-10010101-01010101
// CHECK: asrr    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10010101-01010101
asrr    z23.d, p3/m, z23.d, z13.d  // 00000100-11010100-10001101-10110111
// CHECK: asrr    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10001101-10110111
ASRR    Z23.D, P3/M, Z23.D, Z13.D  // 00000100-11010100-10001101-10110111
// CHECK: asrr    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd4,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11010100-10001101-10110111
