// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsr     z23.h, z13.h, #8  // 00000100-00111000-10010101-10110111
// CHECK: lsr     z23.h, z13.h, #8 // encoding: [0xb7,0x95,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10010101-10110111
LSR     Z23.H, Z13.H, #8  // 00000100-00111000-10010101-10110111
// CHECK: lsr     z23.h, z13.h, #8 // encoding: [0xb7,0x95,0x38,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111000-10010101-10110111
lsr     z21.h, z10.h, #11  // 00000100-00110101-10010101-01010101
// CHECK: lsr     z21.h, z10.h, #11 // encoding: [0x55,0x95,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10010101-01010101
LSR     Z21.H, Z10.H, #11  // 00000100-00110101-10010101-01010101
// CHECK: lsr     z21.h, z10.h, #11 // encoding: [0x55,0x95,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10010101-01010101
lsr     z31.h, z31.h, #1  // 00000100-00111111-10010111-11111111
// CHECK: lsr     z31.h, z31.h, #1 // encoding: [0xff,0x97,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10010111-11111111
LSR     Z31.H, Z31.H, #1  // 00000100-00111111-10010111-11111111
// CHECK: lsr     z31.h, z31.h, #1 // encoding: [0xff,0x97,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10010111-11111111
lsr     z0.h, z0.h, #16  // 00000100-00110000-10010100-00000000
// CHECK: lsr     z0.h, z0.h, #16 // encoding: [0x00,0x94,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10010100-00000000
LSR     Z0.H, Z0.H, #16  // 00000100-00110000-10010100-00000000
// CHECK: lsr     z0.h, z0.h, #16 // encoding: [0x00,0x94,0x30,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110000-10010100-00000000
