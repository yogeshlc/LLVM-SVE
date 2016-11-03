// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
adr     z31.d, [z31.d, z31.d, sxtw]  // 00000100-00111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw] // encoding: [0xff,0xa3,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10100011-11111111
ADR     Z31.D, [Z31.D, Z31.D, SXTW]  // 00000100-00111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw] // encoding: [0xff,0xa3,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-10100011-11111111
adr     z23.d, [z13.d, z8.d, sxtw]  // 00000100-00101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw] // encoding: [0xb7,0xa1,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10100001-10110111
ADR     Z23.D, [Z13.D, Z8.D, SXTW]  // 00000100-00101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw] // encoding: [0xb7,0xa1,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-10100001-10110111
adr     z21.d, [z10.d, z21.d, sxtw]  // 00000100-00110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw] // encoding: [0x55,0xa1,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10100001-01010101
ADR     Z21.D, [Z10.D, Z21.D, SXTW]  // 00000100-00110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw] // encoding: [0x55,0xa1,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-10100001-01010101
adr     z0.d, [z0.d, z0.d, sxtw]  // 00000100-00100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw] // encoding: [0x00,0xa0,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-10100000-00000000
ADR     Z0.D, [Z0.D, Z0.D, SXTW]  // 00000100-00100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw] // encoding: [0x00,0xa0,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-10100000-00000000
