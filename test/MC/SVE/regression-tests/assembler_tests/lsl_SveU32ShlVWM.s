// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z21.s, p5/m, z21.s, z10.d  // 00000100-10011011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10010101-01010101
LSL     Z21.S, P5/M, Z21.S, Z10.D  // 00000100-10011011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10010101-01010101
lsl     z23.s, p3/m, z23.s, z13.d  // 00000100-10011011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10001101-10110111
LSL     Z23.S, P3/M, Z23.S, Z13.D  // 00000100-10011011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10001101-10110111
lsl     z31.s, p7/m, z31.s, z31.d  // 00000100-10011011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10011111-11111111
LSL     Z31.S, P7/M, Z31.S, Z31.D  // 00000100-10011011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10011111-11111111
lsl     z0.s, p0/m, z0.s, z0.d  // 00000100-10011011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10000000-00000000
LSL     Z0.S, P0/M, Z0.S, Z0.D  // 00000100-10011011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x9b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10011011-10000000-00000000
