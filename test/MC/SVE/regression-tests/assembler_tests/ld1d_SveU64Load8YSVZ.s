// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3]  // 11000101-10110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3] // encoding: [0x55,0x55,0xb5,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10110101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, UXTW #3]  // 11000101-10110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3] // encoding: [0x55,0x55,0xb5,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10110101-01010101-01010101
ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3]  // 11000101-10111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3] // encoding: [0xff,0x5f,0xbf,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10111111-01011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, UXTW #3]  // 11000101-10111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3] // encoding: [0xff,0x5f,0xbf,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10111111-01011111-11111111
ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3]  // 11000101-10101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x4d,0xa8,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10101000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, UXTW #3]  // 11000101-10101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x4d,0xa8,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10101000-01001101-10110111
ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3]  // 11000101-10100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3] // encoding: [0x00,0x40,0xa0,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10100000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, UXTW #3]  // 11000101-10100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3] // encoding: [0x00,0x40,0xa0,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10100000-01000000-00000000
