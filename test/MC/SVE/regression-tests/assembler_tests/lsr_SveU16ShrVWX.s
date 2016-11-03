// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsr     z0.h, z0.h, z0.d  // 00000100-01100000-10000100-00000000
// CHECK: lsr     z0.h, z0.h, z0.d // encoding: [0x00,0x84,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-10000100-00000000
LSR     Z0.H, Z0.H, Z0.D  // 00000100-01100000-10000100-00000000
// CHECK: lsr     z0.h, z0.h, z0.d // encoding: [0x00,0x84,0x60,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01100000-10000100-00000000
lsr     z21.h, z10.h, z21.d  // 00000100-01110101-10000101-01010101
// CHECK: lsr     z21.h, z10.h, z21.d // encoding: [0x55,0x85,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-10000101-01010101
LSR     Z21.H, Z10.H, Z21.D  // 00000100-01110101-10000101-01010101
// CHECK: lsr     z21.h, z10.h, z21.d // encoding: [0x55,0x85,0x75,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01110101-10000101-01010101
lsr     z31.h, z31.h, z31.d  // 00000100-01111111-10000111-11111111
// CHECK: lsr     z31.h, z31.h, z31.d // encoding: [0xff,0x87,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-10000111-11111111
LSR     Z31.H, Z31.H, Z31.D  // 00000100-01111111-10000111-11111111
// CHECK: lsr     z31.h, z31.h, z31.d // encoding: [0xff,0x87,0x7f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01111111-10000111-11111111
lsr     z23.h, z13.h, z8.d  // 00000100-01101000-10000101-10110111
// CHECK: lsr     z23.h, z13.h, z8.d // encoding: [0xb7,0x85,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-10000101-10110111
LSR     Z23.H, Z13.H, Z8.D  // 00000100-01101000-10000101-10110111
// CHECK: lsr     z23.h, z13.h, z8.d // encoding: [0xb7,0x85,0x68,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01101000-10000101-10110111
