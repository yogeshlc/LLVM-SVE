; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve -fp-contract=fast < %s | FileCheck %s

define void @mla_b(<n x 16 x i8>* %_a, <n x 16 x i8>* %_b,
                   <n x 16 x i8>* %_c) {
; CHECK-LABEL: mla_b:
; CHECK: mla {{z[0-9]+.b}},
       %a = load <n x 16 x i8>, <n x 16 x i8>* %_a
       %b = load <n x 16 x i8>, <n x 16 x i8>* %_b
       %c = load <n x 16 x i8>, <n x 16 x i8>* %_c
       %tmp1 = mul <n x 16 x i8> %a, %b
       %tmp2 = add <n x 16 x i8> %c, %tmp1
       store <n x 16 x i8> %tmp2, <n x 16 x i8>* %_a
       ret void
}

define void @mla_h(<n x 8 x i16>* %_a, <n x 8 x i16>* %_b,
                   <n x 8 x i16>* %_c) {
; CHECK-LABEL: mla_h:
; CHECK: mla {{z[0-9]+.h}},
       %a = load <n x 8 x i16>, <n x 8 x i16>* %_a
       %b = load <n x 8 x i16>, <n x 8 x i16>* %_b
       %c = load <n x 8 x i16>, <n x 8 x i16>* %_c
       %tmp1 = mul <n x 8 x i16> %a, %b
       %tmp2 = add <n x 8 x i16> %c, %tmp1
       store <n x 8 x i16> %tmp2, <n x 8 x i16>* %_a
       ret void
}

define void @mla_s(<n x 4 x i32>* %_a, <n x 4 x i32>* %_b,
                   <n x 4 x i32>* %_c) {
; CHECK-LABEL: mla_s:
; CHECK: mla {{z[0-9]+.s}},
       %a = load <n x 4 x i32>, <n x 4 x i32>* %_a
       %b = load <n x 4 x i32>, <n x 4 x i32>* %_b
       %c = load <n x 4 x i32>, <n x 4 x i32>* %_c
       %tmp1 = mul <n x 4 x i32> %a, %b
       %tmp2 = add <n x 4 x i32> %c, %tmp1
       store <n x 4 x i32> %tmp2, <n x 4 x i32>* %_a
       ret void
}

define void @mla_d(<n x 2 x i64>* %_a, <n x 2 x i64>* %_b,
                   <n x 2 x i64>* %_c) {
; CHECK-LABEL: mla_d:
; CHECK: mla {{z[0-9]+.d}},
       %a = load <n x 2 x i64>, <n x 2 x i64>* %_a
       %b = load <n x 2 x i64>, <n x 2 x i64>* %_b
       %c = load <n x 2 x i64>, <n x 2 x i64>* %_c
       %tmp1 = mul <n x 2 x i64> %a, %b
       %tmp2 = add <n x 2 x i64> %c, %tmp1
       store <n x 2 x i64> %tmp2, <n x 2 x i64>* %_a
       ret void
}

define void @mls_b(<n x 16 x i8>* %_a, <n x 16 x i8>* %_b,
                   <n x 16 x i8>* %_c) {
; CHECK-LABEL: mls_b:
; CHECK: mls {{z[0-9]+.b}},
       %a = load <n x 16 x i8>, <n x 16 x i8>* %_a
       %b = load <n x 16 x i8>, <n x 16 x i8>* %_b
       %c = load <n x 16 x i8>, <n x 16 x i8>* %_c
       %tmp1 = mul <n x 16 x i8> %a, %b
       %tmp2 = sub <n x 16 x i8> %c, %tmp1
       store <n x 16 x i8> %tmp2, <n x 16 x i8>* %_a
       ret void
}

define void @mls_h(<n x 8 x i16>* %_a, <n x 8 x i16>* %_b,
                   <n x 8 x i16>* %_c) {
; CHECK-LABEL: mls_h:
; CHECK: mls {{z[0-9]+.h}},
       %a = load <n x 8 x i16>, <n x 8 x i16>* %_a
       %b = load <n x 8 x i16>, <n x 8 x i16>* %_b
       %c = load <n x 8 x i16>, <n x 8 x i16>* %_c
       %tmp1 = mul <n x 8 x i16> %a, %b
       %tmp2 = sub <n x 8 x i16> %c, %tmp1
       store <n x 8 x i16> %tmp2, <n x 8 x i16>* %_a
       ret void
}

define void @mls_s(<n x 4 x i32>* %_a, <n x 4 x i32>* %_b,
                   <n x 4 x i32>* %_c) {
; CHECK-LABEL: mls_s:
; CHECK: mls {{z[0-9]+.s}},
       %a = load <n x 4 x i32>, <n x 4 x i32>* %_a
       %b = load <n x 4 x i32>, <n x 4 x i32>* %_b
       %c = load <n x 4 x i32>, <n x 4 x i32>* %_c
       %tmp1 = mul <n x 4 x i32> %a, %b
       %tmp2 = sub <n x 4 x i32> %c, %tmp1
       store <n x 4 x i32> %tmp2, <n x 4 x i32>* %_a
       ret void
}

define void @mls_d(<n x 2 x i64>* %_a, <n x 2 x i64>* %_b,
                   <n x 2 x i64>* %_c) {
; CHECK-LABEL: mls_d:
; CHECK: mls {{z[0-9]+.d}},
       %a = load <n x 2 x i64>, <n x 2 x i64>* %_a
       %b = load <n x 2 x i64>, <n x 2 x i64>* %_b
       %c = load <n x 2 x i64>, <n x 2 x i64>* %_c
       %tmp1 = mul <n x 2 x i64> %a, %b
       %tmp2 = sub <n x 2 x i64> %c, %tmp1
       store <n x 2 x i64> %tmp2, <n x 2 x i64>* %_a
       ret void
}
