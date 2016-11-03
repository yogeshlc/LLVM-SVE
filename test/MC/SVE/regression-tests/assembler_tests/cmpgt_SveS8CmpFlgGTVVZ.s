// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpgt   p0.b, p0/z, z0.b, z0.b  // 00100100-00000000-10000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.b // encoding: [0x10,0x80,0x00,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00000000-10000000-00010000
CMPGT   P0.B, P0/Z, Z0.B, Z0.B  // 00100100-00000000-10000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.b // encoding: [0x10,0x80,0x00,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00000000-10000000-00010000
cmpgt   p15.b, p7/z, z31.b, z31.b  // 00100100-00011111-10011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.b // encoding: [0xff,0x9f,0x1f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00011111-10011111-11111111
CMPGT   P15.B, P7/Z, Z31.B, Z31.B  // 00100100-00011111-10011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.b // encoding: [0xff,0x9f,0x1f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00011111-10011111-11111111
cmpgt   p5.b, p5/z, z10.b, z21.b  // 00100100-00010101-10010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.b // encoding: [0x55,0x95,0x15,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00010101-10010101-01010101
CMPGT   P5.B, P5/Z, Z10.B, Z21.B  // 00100100-00010101-10010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.b // encoding: [0x55,0x95,0x15,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00010101-10010101-01010101
cmpgt   p7.b, p3/z, z13.b, z8.b  // 00100100-00001000-10001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.b // encoding: [0xb7,0x8d,0x08,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00001000-10001101-10110111
CMPGT   P7.B, P3/Z, Z13.B, Z8.B  // 00100100-00001000-10001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.b // encoding: [0xb7,0x8d,0x08,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00001000-10001101-10110111
