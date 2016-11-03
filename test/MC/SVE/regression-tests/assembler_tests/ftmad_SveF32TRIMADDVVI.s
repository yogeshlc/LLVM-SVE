// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftmad   z0.s, z0.s, z0.s, #0  // 01100101-10010000-10000000-00000000
// CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-10000000-00000000
FTMAD   Z0.S, Z0.S, Z0.S, #0  // 01100101-10010000-10000000-00000000
// CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-10000000-00000000
ftmad   z23.s, z23.s, z13.s, #0  // 01100101-10010000-10000001-10110111
// CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-10000001-10110111
FTMAD   Z23.S, Z23.S, Z13.S, #0  // 01100101-10010000-10000001-10110111
// CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010000-10000001-10110111
ftmad   z31.s, z31.s, z31.s, #7  // 01100101-10010111-10000011-11111111
// CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010111-10000011-11111111
FTMAD   Z31.S, Z31.S, Z31.S, #7  // 01100101-10010111-10000011-11111111
// CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010111-10000011-11111111
ftmad   z21.s, z21.s, z10.s, #5  // 01100101-10010101-10000001-01010101
// CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10000001-01010101
FTMAD   Z21.S, Z21.S, Z10.S, #5  // 01100101-10010101-10000001-01010101
// CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-10010101-10000001-01010101
