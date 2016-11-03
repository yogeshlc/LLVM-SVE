// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpeq   p15.b, p7/z, z31.b, z31.d  // 00100100-00011111-00111111-11101111
// CHECK: cmpeq   p15.b, p7/z, z31.b, z31.d // encoding: [0xef,0x3f,0x1f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00011111-00111111-11101111
CMPEQ   P15.B, P7/Z, Z31.B, Z31.D  // 00100100-00011111-00111111-11101111
// CHECK: cmpeq   p15.b, p7/z, z31.b, z31.d // encoding: [0xef,0x3f,0x1f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00011111-00111111-11101111
cmpeq   p0.b, p0/z, z0.b, z0.d  // 00100100-00000000-00100000-00000000
// CHECK: cmpeq   p0.b, p0/z, z0.b, z0.d // encoding: [0x00,0x20,0x00,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00000000-00100000-00000000
CMPEQ   P0.B, P0/Z, Z0.B, Z0.D  // 00100100-00000000-00100000-00000000
// CHECK: cmpeq   p0.b, p0/z, z0.b, z0.d // encoding: [0x00,0x20,0x00,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00000000-00100000-00000000
cmpeq   p5.b, p5/z, z10.b, z21.d  // 00100100-00010101-00110101-01000101
// CHECK: cmpeq   p5.b, p5/z, z10.b, z21.d // encoding: [0x45,0x35,0x15,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00010101-00110101-01000101
CMPEQ   P5.B, P5/Z, Z10.B, Z21.D  // 00100100-00010101-00110101-01000101
// CHECK: cmpeq   p5.b, p5/z, z10.b, z21.d // encoding: [0x45,0x35,0x15,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00010101-00110101-01000101
cmpeq   p7.b, p3/z, z13.b, z8.d  // 00100100-00001000-00101101-10100111
// CHECK: cmpeq   p7.b, p3/z, z13.b, z8.d // encoding: [0xa7,0x2d,0x08,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00001000-00101101-10100111
CMPEQ   P7.B, P3/Z, Z13.B, Z8.D  // 00100100-00001000-00101101-10100111
// CHECK: cmpeq   p7.b, p3/z, z13.b, z8.d // encoding: [0xa7,0x2d,0x08,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-00001000-00101101-10100111
