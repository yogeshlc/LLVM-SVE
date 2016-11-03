// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmov    z23.d, p8/m, #0.90625  // 00000101-11011000-11001101-10110111
// CHECK: fmov    z23.d, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xd8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011000-11001101-10110111
FMOV    Z23.D, P8/M, #0.90625  // 00000101-11011000-11001101-10110111
// CHECK: fmov    z23.d, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xd8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011000-11001101-10110111
fmov    z21.d, p5/m, #-13.0  // 00000101-11010101-11010101-01010101
// CHECK: fmov    z21.d, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0xd5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010101-11010101-01010101
FMOV    Z21.D, P5/M, #-13.0  // 00000101-11010101-11010101-01010101
// CHECK: fmov    z21.d, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0xd5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010101-11010101-01010101
fmov    z31.d, p15/m, #-1.9375  // 00000101-11011111-11011111-11111111
// CHECK: fmov    z31.d, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xdf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011111-11011111-11111111
FMOV    Z31.D, P15/M, #-1.9375  // 00000101-11011111-11011111-11111111
// CHECK: fmov    z31.d, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xdf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11011111-11011111-11111111
fmov    z0.d, p0/m, #2.0  // 00000101-11010000-11000000-00000000
// CHECK: fmov    z0.d, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0xd0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010000-11000000-00000000
FMOV    Z0.D, P0/M, #2.0  // 00000101-11010000-11000000-00000000
// CHECK: fmov    z0.d, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0xd0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11010000-11000000-00000000
