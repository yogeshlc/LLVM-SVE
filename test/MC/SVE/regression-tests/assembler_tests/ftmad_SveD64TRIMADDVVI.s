// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftmad   z31.d, z31.d, z31.d, #7  // 01100101-11010111-10000011-11111111
// CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010111-10000011-11111111
FTMAD   Z31.D, Z31.D, Z31.D, #7  // 01100101-11010111-10000011-11111111
// CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010111-10000011-11111111
ftmad   z21.d, z21.d, z10.d, #5  // 01100101-11010101-10000001-01010101
// CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-10000001-01010101
FTMAD   Z21.D, Z21.D, Z10.D, #5  // 01100101-11010101-10000001-01010101
// CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010101-10000001-01010101
ftmad   z23.d, z23.d, z13.d, #0  // 01100101-11010000-10000001-10110111
// CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10000001-10110111
FTMAD   Z23.D, Z23.D, Z13.D, #0  // 01100101-11010000-10000001-10110111
// CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10000001-10110111
ftmad   z0.d, z0.d, z0.d, #0  // 01100101-11010000-10000000-00000000
// CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10000000-00000000
FTMAD   Z0.D, Z0.D, Z0.D, #0  // 01100101-11010000-10000000-00000000
// CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11010000-10000000-00000000
