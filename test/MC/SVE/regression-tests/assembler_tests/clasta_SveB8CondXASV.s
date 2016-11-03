// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clasta  b21, p5, b21, z10.b  // 00000101-00101010-10010101-01010101
// CHECK: clasta  b21, p5, b21, z10.b // encoding: [0x55,0x95,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10010101-01010101
CLASTA  B21, P5, B21, Z10.B  // 00000101-00101010-10010101-01010101
// CHECK: clasta  b21, p5, b21, z10.b // encoding: [0x55,0x95,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10010101-01010101
clasta  b0, p0, b0, z0.b  // 00000101-00101010-10000000-00000000
// CHECK: clasta  b0, p0, b0, z0.b // encoding: [0x00,0x80,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10000000-00000000
CLASTA  B0, P0, B0, Z0.B  // 00000101-00101010-10000000-00000000
// CHECK: clasta  b0, p0, b0, z0.b // encoding: [0x00,0x80,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10000000-00000000
clasta  b23, p3, b23, z13.b  // 00000101-00101010-10001101-10110111
// CHECK: clasta  b23, p3, b23, z13.b // encoding: [0xb7,0x8d,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10001101-10110111
CLASTA  B23, P3, B23, Z13.B  // 00000101-00101010-10001101-10110111
// CHECK: clasta  b23, p3, b23, z13.b // encoding: [0xb7,0x8d,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10001101-10110111
clasta  b31, p7, b31, z31.b  // 00000101-00101010-10011111-11111111
// CHECK: clasta  b31, p7, b31, z31.b // encoding: [0xff,0x9f,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10011111-11111111
CLASTA  B31, P7, B31, Z31.B  // 00000101-00101010-10011111-11111111
// CHECK: clasta  b31, p7, b31, z31.b // encoding: [0xff,0x9f,0x2a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101010-10011111-11111111
