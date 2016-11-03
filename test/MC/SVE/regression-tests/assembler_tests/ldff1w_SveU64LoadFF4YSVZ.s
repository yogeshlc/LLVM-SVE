// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw #2]  // 11000101-00101000-01101101-10110111
// CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x6d,0x28,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00101000-01101101-10110111
LDFF1W  {Z23.D}, P3/Z, [X13, Z8.D, UXTW #2]  // 11000101-00101000-01101101-10110111
// CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x6d,0x28,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00101000-01101101-10110111
ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw #2]  // 11000101-00111111-01111111-11111111
// CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw #2] // encoding: [0xff,0x7f,0x3f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00111111-01111111-11111111
LDFF1W  {Z31.D}, P7/Z, [SP, Z31.D, UXTW #2]  // 11000101-00111111-01111111-11111111
// CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw #2] // encoding: [0xff,0x7f,0x3f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00111111-01111111-11111111
ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw #2]  // 11000101-00100000-01100000-00000000
// CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw #2] // encoding: [0x00,0x60,0x20,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00100000-01100000-00000000
LDFF1W  {Z0.D}, P0/Z, [X0, Z0.D, UXTW #2]  // 11000101-00100000-01100000-00000000
// CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw #2] // encoding: [0x00,0x60,0x20,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00100000-01100000-00000000
ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw #2]  // 11000101-00110101-01110101-01010101
// CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw #2] // encoding: [0x55,0x75,0x35,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00110101-01110101-01010101
LDFF1W  {Z21.D}, P5/Z, [X10, Z21.D, UXTW #2]  // 11000101-00110101-01110101-01010101
// CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw #2] // encoding: [0x55,0x75,0x35,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-00110101-01110101-01010101
