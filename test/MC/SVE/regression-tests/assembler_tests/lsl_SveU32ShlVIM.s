// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z31.s, p7/m, z31.s, #31  // 00000100-01000011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, #31 // encoding: [0xff,0x9f,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10011111-11111111
LSL     Z31.S, P7/M, Z31.S, #31  // 00000100-01000011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, #31 // encoding: [0xff,0x9f,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10011111-11111111
lsl     z23.s, p3/m, z23.s, #13  // 00000100-01000011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, #13 // encoding: [0xb7,0x8d,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10001101-10110111
LSL     Z23.S, P3/M, Z23.S, #13  // 00000100-01000011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, #13 // encoding: [0xb7,0x8d,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10001101-10110111
lsl     z21.s, p5/m, z21.s, #10  // 00000100-01000011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, #10 // encoding: [0x55,0x95,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10010101-01010101
LSL     Z21.S, P5/M, Z21.S, #10  // 00000100-01000011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, #10 // encoding: [0x55,0x95,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10010101-01010101
lsl     z0.s, p0/m, z0.s, #0  // 00000100-01000011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, #0 // encoding: [0x00,0x80,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10000000-00000000
LSL     Z0.S, P0/M, Z0.S, #0  // 00000100-01000011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, #0 // encoding: [0x00,0x80,0x43,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000011-10000000-00000000
