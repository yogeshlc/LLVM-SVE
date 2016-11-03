// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z23.s, z13.s, z8.d  // 00000100-10101000-10001101-10110111
// CHECK: lsl     z23.s, z13.s, z8.d // encoding: [0xb7,0x8d,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10001101-10110111
LSL     Z23.S, Z13.S, Z8.D  // 00000100-10101000-10001101-10110111
// CHECK: lsl     z23.s, z13.s, z8.d // encoding: [0xb7,0x8d,0xa8,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10101000-10001101-10110111
lsl     z21.s, z10.s, z21.d  // 00000100-10110101-10001101-01010101
// CHECK: lsl     z21.s, z10.s, z21.d // encoding: [0x55,0x8d,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10001101-01010101
LSL     Z21.S, Z10.S, Z21.D  // 00000100-10110101-10001101-01010101
// CHECK: lsl     z21.s, z10.s, z21.d // encoding: [0x55,0x8d,0xb5,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10110101-10001101-01010101
lsl     z0.s, z0.s, z0.d  // 00000100-10100000-10001100-00000000
// CHECK: lsl     z0.s, z0.s, z0.d // encoding: [0x00,0x8c,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10001100-00000000
LSL     Z0.S, Z0.S, Z0.D  // 00000100-10100000-10001100-00000000
// CHECK: lsl     z0.s, z0.s, z0.d // encoding: [0x00,0x8c,0xa0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10100000-10001100-00000000
lsl     z31.s, z31.s, z31.d  // 00000100-10111111-10001111-11111111
// CHECK: lsl     z31.s, z31.s, z31.d // encoding: [0xff,0x8f,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10001111-11111111
LSL     Z31.S, Z31.S, Z31.D  // 00000100-10111111-10001111-11111111
// CHECK: lsl     z31.s, z31.s, z31.d // encoding: [0xff,0x8f,0xbf,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10111111-10001111-11111111
