// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
adr     z23.s, [z13.s, z8.s, lsl #2]  // 00000100-10101000-10101001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #2] // encoding: [0xb7,0xa9,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10101001-10110111
ADR     Z23.S, [Z13.S, Z8.S, LSL #2]  // 00000100-10101000-10101001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #2] // encoding: [0xb7,0xa9,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10101001-10110111
adr     z21.s, [z10.s, z21.s, lsl #2]  // 00000100-10110101-10101001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #2] // encoding: [0x55,0xa9,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10101001-01010101
ADR     Z21.S, [Z10.S, Z21.S, LSL #2]  // 00000100-10110101-10101001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #2] // encoding: [0x55,0xa9,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10101001-01010101
adr     z31.s, [z31.s, z31.s, lsl #2]  // 00000100-10111111-10101011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #2] // encoding: [0xff,0xab,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10101011-11111111
ADR     Z31.S, [Z31.S, Z31.S, LSL #2]  // 00000100-10111111-10101011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #2] // encoding: [0xff,0xab,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10101011-11111111
adr     z0.s, [z0.s, z0.s, lsl #2]  // 00000100-10100000-10101000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #2] // encoding: [0x00,0xa8,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10101000-00000000
ADR     Z0.S, [Z0.S, Z0.S, LSL #2]  // 00000100-10100000-10101000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #2] // encoding: [0x00,0xa8,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10101000-00000000
