// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rsb  {z23.h}, p3/z, [x13, #8]  // 10000101-11001000-11001101-10110111
// CHECK: ld1rsb  {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xcd,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-11001101-10110111
LD1RSB  {Z23.H}, P3/Z, [X13, #8]  // 10000101-11001000-11001101-10110111
// CHECK: ld1rsb  {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xcd,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-11001101-10110111
ld1rsb  {z21.h}, p5/z, [x10, #21]  // 10000101-11010101-11010101-01010101
// CHECK: ld1rsb  {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xd5,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-11010101-01010101
LD1RSB  {Z21.H}, P5/Z, [X10, #21]  // 10000101-11010101-11010101-01010101
// CHECK: ld1rsb  {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xd5,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-11010101-01010101
ld1rsb  {z31.h}, p7/z, [sp, #63]  // 10000101-11111111-11011111-11111111
// CHECK: ld1rsb  {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xdf,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-11011111-11111111
LD1RSB  {Z31.H}, P7/Z, [SP, #63]  // 10000101-11111111-11011111-11111111
// CHECK: ld1rsb  {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xdf,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-11011111-11111111
ld1rsb  {z0.h}, p0/z, [x0]  // 10000101-11000000-11000000-00000000
// CHECK: ld1rsb  {z0.h}, p0/z, [x0] // encoding: [0x00,0xc0,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-11000000-00000000
LD1RSB  {Z0.H}, P0/Z, [X0]  // 10000101-11000000-11000000-00000000
// CHECK: ld1rsb  {z0.h}, p0/z, [x0] // encoding: [0x00,0xc0,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-11000000-00000000
