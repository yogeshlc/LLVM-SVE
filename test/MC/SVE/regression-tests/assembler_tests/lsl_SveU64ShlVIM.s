// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z23.d, p3/m, z23.d, #45  // 00000100-11000011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, #45 // encoding: [0xb7,0x8d,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10001101-10110111
LSL     Z23.D, P3/M, Z23.D, #45  // 00000100-11000011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, #45 // encoding: [0xb7,0x8d,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10001101-10110111
lsl     z0.d, p0/m, z0.d, #0  // 00000100-10000011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, #0 // encoding: [0x00,0x80,0x83,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000011-10000000-00000000
LSL     Z0.D, P0/M, Z0.D, #0  // 00000100-10000011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, #0 // encoding: [0x00,0x80,0x83,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10000011-10000000-00000000
lsl     z31.d, p7/m, z31.d, #63  // 00000100-11000011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, #63 // encoding: [0xff,0x9f,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10011111-11111111
LSL     Z31.D, P7/M, Z31.D, #63  // 00000100-11000011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, #63 // encoding: [0xff,0x9f,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10011111-11111111
lsl     z21.d, p5/m, z21.d, #42  // 00000100-11000011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, #42 // encoding: [0x55,0x95,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10010101-01010101
LSL     Z21.D, P5/M, Z21.D, #42  // 00000100-11000011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, #42 // encoding: [0x55,0x95,0xc3,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11000011-10010101-01010101
