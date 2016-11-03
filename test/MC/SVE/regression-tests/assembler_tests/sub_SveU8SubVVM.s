// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sub     z31.b, p7/m, z31.b, z31.b  // 00000100-00000001-00011111-11111111
// CHECK: sub     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x1f,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00011111-11111111
SUB     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00000001-00011111-11111111
// CHECK: sub     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x1f,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00011111-11111111
sub     z21.b, p5/m, z21.b, z10.b  // 00000100-00000001-00010101-01010101
// CHECK: sub     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x15,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00010101-01010101
SUB     Z21.B, P5/M, Z21.B, Z10.B  // 00000100-00000001-00010101-01010101
// CHECK: sub     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x15,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00010101-01010101
sub     z0.b, p0/m, z0.b, z0.b  // 00000100-00000001-00000000-00000000
// CHECK: sub     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x00,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00000000-00000000
SUB     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00000001-00000000-00000000
// CHECK: sub     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x00,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00000000-00000000
sub     z23.b, p3/m, z23.b, z13.b  // 00000100-00000001-00001101-10110111
// CHECK: sub     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x0d,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00001101-10110111
SUB     Z23.B, P3/M, Z23.B, Z13.B  // 00000100-00000001-00001101-10110111
// CHECK: sub     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x0d,0x01,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00000001-00001101-10110111
