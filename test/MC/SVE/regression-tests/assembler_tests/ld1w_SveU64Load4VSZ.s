// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1w    {z31.d}, p7/z, [sp, z31.d]  // 11000101-01011111-11011111-11111111
// CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0x5f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01011111-11011111-11111111
LD1W    {Z31.D}, P7/Z, [SP, Z31.D]  // 11000101-01011111-11011111-11111111
// CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0x5f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01011111-11011111-11111111
ld1w    {z0.d}, p0/z, [x0, z0.d]  // 11000101-01000000-11000000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0x40,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01000000-11000000-00000000
LD1W    {Z0.D}, P0/Z, [X0, Z0.D]  // 11000101-01000000-11000000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0x40,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01000000-11000000-00000000
ld1w    {z21.d}, p5/z, [x10, z21.d]  // 11000101-01010101-11010101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0x55,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01010101-11010101-01010101
LD1W    {Z21.D}, P5/Z, [X10, Z21.D]  // 11000101-01010101-11010101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0x55,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01010101-11010101-01010101
ld1w    {z23.d}, p3/z, [x13, z8.d]  // 11000101-01001000-11001101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0x48,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01001000-11001101-10110111
LD1W    {Z23.D}, P3/Z, [X13, Z8.D]  // 11000101-01001000-11001101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0x48,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-01001000-11001101-10110111
