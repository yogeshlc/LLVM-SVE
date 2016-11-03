// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sel     z0.d, p0, z0.d, z0.d  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
SEL     Z0.D, P0, Z0.D, Z0.D  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
sel     z23.d, p11, z13.d, z8.d  // 00000101-11101000-11101101-10110111
// CHECK: sel     z23.d, p11, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-11101101-10110111
SEL     Z23.D, P11, Z13.D, Z8.D  // 00000101-11101000-11101101-10110111
// CHECK: sel     z23.d, p11, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-11101101-10110111
sel     z21.d, p5, z10.d, z21.d  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
SEL     Z21.D, P5, Z10.D, Z21.D  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
sel     z31.d, p15, z31.d, z31.d  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
SEL     Z31.D, P15, Z31.D, Z31.D  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
