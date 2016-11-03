// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rsb  {z21.d}, p5/z, [x10, #21]  // 10000101-11010101-10010101-01010101
// CHECK: ld1rsb  {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0x95,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-10010101-01010101
LD1RSB  {Z21.D}, P5/Z, [X10, #21]  // 10000101-11010101-10010101-01010101
// CHECK: ld1rsb  {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0x95,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-10010101-01010101
ld1rsb  {z23.d}, p3/z, [x13, #8]  // 10000101-11001000-10001101-10110111
// CHECK: ld1rsb  {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-10001101-10110111
LD1RSB  {Z23.D}, P3/Z, [X13, #8]  // 10000101-11001000-10001101-10110111
// CHECK: ld1rsb  {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-10001101-10110111
ld1rsb  {z0.d}, p0/z, [x0]  // 10000101-11000000-10000000-00000000
// CHECK: ld1rsb  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-10000000-00000000
LD1RSB  {Z0.D}, P0/Z, [X0]  // 10000101-11000000-10000000-00000000
// CHECK: ld1rsb  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-10000000-00000000
ld1rsb  {z31.d}, p7/z, [sp, #63]  // 10000101-11111111-10011111-11111111
// CHECK: ld1rsb  {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-10011111-11111111
LD1RSB  {Z31.D}, P7/Z, [SP, #63]  // 10000101-11111111-10011111-11111111
// CHECK: ld1rsb  {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-10011111-11111111
