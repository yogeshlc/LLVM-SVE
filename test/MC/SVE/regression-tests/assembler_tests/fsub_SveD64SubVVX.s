// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fsub    z23.d, z13.d, z8.d  // 01100101-11001000-00000101-10110111
// CHECK: fsub    z23.d, z13.d, z8.d // encoding: [0xb7,0x05,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-00000101-10110111
FSUB    Z23.D, Z13.D, Z8.D  // 01100101-11001000-00000101-10110111
// CHECK: fsub    z23.d, z13.d, z8.d // encoding: [0xb7,0x05,0xc8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11001000-00000101-10110111
fsub    z0.d, z0.d, z0.d  // 01100101-11000000-00000100-00000000
// CHECK: fsub    z0.d, z0.d, z0.d // encoding: [0x00,0x04,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-00000100-00000000
FSUB    Z0.D, Z0.D, Z0.D  // 01100101-11000000-00000100-00000000
// CHECK: fsub    z0.d, z0.d, z0.d // encoding: [0x00,0x04,0xc0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11000000-00000100-00000000
fsub    z21.d, z10.d, z21.d  // 01100101-11010101-00000101-01010101
// CHECK: fsub    z21.d, z10.d, z21.d // encoding: [0x55,0x05,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-00000101-01010101
FSUB    Z21.D, Z10.D, Z21.D  // 01100101-11010101-00000101-01010101
// CHECK: fsub    z21.d, z10.d, z21.d // encoding: [0x55,0x05,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-00000101-01010101
fsub    z31.d, z31.d, z31.d  // 01100101-11011111-00000111-11111111
// CHECK: fsub    z31.d, z31.d, z31.d // encoding: [0xff,0x07,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-00000111-11111111
FSUB    Z31.D, Z31.D, Z31.D  // 01100101-11011111-00000111-11111111
// CHECK: fsub    z31.d, z31.d, z31.d // encoding: [0xff,0x07,0xdf,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11011111-00000111-11111111
