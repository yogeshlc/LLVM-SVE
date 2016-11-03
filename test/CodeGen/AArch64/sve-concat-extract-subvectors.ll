; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Concat illegal (packed) to legal types

define <n x 16 x i8> @concat_packed_i8(<n x 8 x i8> %a, <n x 8 x i8> %b) {
; CHECK-LABEL: concat_packed_i8:
; CHECK: index [[MASK:z[0-9]+]].b, #0, #1
; CHECK: uzp1 z0.b, z0.b, z1.b
; CHECK: tbl z0.b, {z0.b}, [[MASK]].b
; CHECK: ret
  %sv  = seriesvector i8 0, 1 as <n x 16 x i8>
  %res = shufflevector <n x 8 x i8> %a, <n x 8 x i8> %b, <n x 16 x i8> %sv
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @concat_packed_i16(<n x 4 x i16> %a, <n x 4 x i16> %b) {
; CHECK-LABEL: concat_packed_i16:
; CHECK: index [[MASK:z[0-9]+]].h, #0, #1
; CHECK: uzp1 z0.h, z0.h, z1.h
; CHECK: tbl z0.h, {z0.h}, [[MASK]].h
; CHECK: ret
  %sv  = seriesvector i16 0, 1 as <n x 8 x i16>
  %res = shufflevector <n x 4 x i16> %a, <n x 4 x i16> %b, <n x 8 x i16> %sv
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @concat_packed_i32(<n x 2 x i32> %a, <n x 2 x i32> %b) {
; CHECK-LABEL: concat_packed_i32:
; CHECK: index [[MASK:z[0-9]+]].s, #0, #1
; CHECK: uzp1 z0.s, z0.s, z1.s
; CHECK: tbl z0.s, {z0.s}, [[MASK]].s
; CHECK: ret
  %sv  = seriesvector i32 0, 1 as <n x 4 x i32>
  %res = shufflevector <n x 2 x i32> %a, <n x 2 x i32> %b, <n x 4 x i32> %sv
  ret <n x 4 x i32> %res
}

;; Concat legal to illegal types

define <n x 32 x i8> @concat_wide_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: concat_wide_i8:
; CHECK: ret
  %sv  = seriesvector i8 0, 1 as <n x 32 x i8>
  %res = shufflevector <n x 16 x i8> %a, <n x 16 x i8> %b, <n x 32 x i8> %sv
  ret <n x 32 x i8> %res
}

define <n x 16 x i16> @concat_wide_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: concat_wide_i16:
; CHECK: ret
  %sv  = seriesvector i16 0, 1 as <n x 16 x i16>
  %res = shufflevector <n x 8 x i16> %a, <n x 8 x i16> %b, <n x 16 x i16> %sv
  ret <n x 16 x i16> %res
}

define <n x 8 x i32> @concat_wide_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: concat_wide_i32:
; CHECK: ret
  %sv  = seriesvector i32 0, 1 as <n x 8 x i32>
  %res = shufflevector <n x 4 x i32> %a, <n x 4 x i32> %b, <n x 8 x i32> %sv
  ret <n x 8 x i32> %res
}

define <n x 4 x i64> @concat_wide_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: concat_wide_i64:
; CHECK: ret
  %sv  = seriesvector i64 0, 1 as <n x 4 x i64>
  %res = shufflevector <n x 2 x i64> %a, <n x 2 x i64> %b, <n x 4 x i64> %sv
  ret <n x 4 x i64> %res
}

;; Extract to packed

define void @extract_packed_i8(<n x 16 x i8> %in, <n x 8 x i8>* %out1, <n x 8 x i8>* %out2) {
; CHECK-LABEL: extract_packed_i8:
; CHECK: uunpkhi [[MASK:z[0-9]+]].h, {{z[0-9]+}}.b
; CHECK: uzp1 {{z[0-9]+}}.b, {{z[0-9]+}}.b, [[MASK]].b
; CHECK: uunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK: uunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK: ret
  %ec = elementcount <n x 8 x i8> zeroinitializer as i8
  %sv1 = seriesvector i8 0, 1 as <n x 8 x i8>
  %sv2 = seriesvector i8 %ec, 1 as <n x 8 x i8>
  %res1 = shufflevector <n x 16 x i8> %in, <n x 16 x i8> undef, <n x 8 x i8> %sv1
  %res2 = shufflevector <n x 16 x i8> %in, <n x 16 x i8> undef, <n x 8 x i8> %sv2
  store <n x 8 x i8> %res1, <n x 8 x i8>* %out1
  store <n x 8 x i8> %res2, <n x 8 x i8>* %out2
  ret void
}

define void @extract_packed_i16(<n x 8 x i16> %in, <n x 4 x i16>* %out1, <n x 4 x i16>* %out2) {
; CHECK-LABEL: extract_packed_i16:
; CHECK: uunpkhi [[MASK:z[0-9]+]].s, {{z[0-9]+}}.h
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, [[MASK]].h
; CHECK: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: ret
  %ec = elementcount <n x 4 x i16> zeroinitializer as i16
  %sv1 = seriesvector i16 0, 1 as <n x 4 x i16>
  %sv2 = seriesvector i16 %ec, 1 as <n x 4 x i16>
  %res1 = shufflevector <n x 8 x i16> %in, <n x 8 x i16> undef, <n x 4 x i16> %sv1
  %res2 = shufflevector <n x 8 x i16> %in, <n x 8 x i16> undef, <n x 4 x i16> %sv2
  store <n x 4 x i16> %res1, <n x 4 x i16>* %out1
  store <n x 4 x i16> %res2, <n x 4 x i16>* %out2
  ret void
}

define void @extract_packed_i32(<n x 4 x i32> %in, <n x 2 x i32>* %out1, <n x 2 x i32>* %out2) {
; CHECK-LABEL: extract_packed_i32:
; CHECK: uunpkhi [[MASK:z[0-9]+]].d, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.s, {{z[0-9]+}}.s, [[MASK]].s
; CHECK: uunpklo {{z[0-9]+}}.d, {{z[0-9]+}}.s
; CHECK: uunpklo {{z[0-9]+}}.d, {{z[0-9]+}}.s
; CHECK: ret
  %ec = elementcount <n x 2 x i32> zeroinitializer as i32
  %sv1 = seriesvector i32 0, 1 as <n x 2 x i32>
  %sv2 = seriesvector i32 %ec, 1 as <n x 2 x i32>
  %res1 = shufflevector <n x 4 x i32> %in, <n x 4 x i32> undef, <n x 2 x i32> %sv1
  %res2 = shufflevector <n x 4 x i32> %in, <n x 4 x i32> undef, <n x 2 x i32> %sv2
  store <n x 2 x i32> %res1, <n x 2 x i32>* %out1
  store <n x 2 x i32> %res2, <n x 2 x i32>* %out2
  ret void
}

;; Extract to legal

define void @extract_wide_i8(<n x 32 x i8> %in, <n x 16 x i8>* %out1, <n x 16 x i8>* %out2) {
; CHECK-LABEL: extract_wide_i8:
; CHECK: ret
  %ec = elementcount <n x 16 x i8> zeroinitializer as i8
  %sv1 = seriesvector i8 0, 1 as <n x 16 x i8>
  %sv2 = seriesvector i8 %ec, 1 as <n x 16 x i8>
  %res1 = shufflevector <n x 32 x i8> %in, <n x 32 x i8> undef, <n x 16 x i8> %sv1
  %res2 = shufflevector <n x 32 x i8> %in, <n x 32 x i8> undef, <n x 16 x i8> %sv2
  store <n x 16 x i8> %res1, <n x 16 x i8>* %out1
  store <n x 16 x i8> %res2, <n x 16 x i8>* %out2
  ret void
}

define void @extract_wide_i16(<n x 16 x i16> %in, <n x 8 x i16>* %out1, <n x 8 x i16>* %out2) {
; CHECK-LABEL: extract_wide_i16:
; CHECK: ret
  %ec = elementcount <n x 8 x i16> zeroinitializer as i16
  %sv1 = seriesvector i16 0, 1 as <n x 8 x i16>
  %sv2 = seriesvector i16 %ec, 1 as <n x 8 x i16>
  %res1 = shufflevector <n x 16 x i16> %in, <n x 16 x i16> undef, <n x 8 x i16> %sv1
  %res2 = shufflevector <n x 16 x i16> %in, <n x 16 x i16> undef, <n x 8 x i16> %sv2
  store <n x 8 x i16> %res1, <n x 8 x i16>* %out1
  store <n x 8 x i16> %res2, <n x 8 x i16>* %out2
  ret void
}

define void @extract_wide_i32(<n x 8 x i32> %in, <n x 4 x i32>* %out1, <n x 4 x i32>* %out2) {
; CHECK-LABEL: extract_wide_i32:
; CHECK: ret
  %ec = elementcount <n x 4 x i32> zeroinitializer as i32
  %sv1 = seriesvector i32 0, 1 as <n x 4 x i32>
  %sv2 = seriesvector i32 %ec, 1 as <n x 4 x i32>
  %res1 = shufflevector <n x 8 x i32> %in, <n x 8 x i32> undef, <n x 4 x i32> %sv1
  %res2 = shufflevector <n x 8 x i32> %in, <n x 8 x i32> undef, <n x 4 x i32> %sv2
  store <n x 4 x i32> %res1, <n x 4 x i32>* %out1
  store <n x 4 x i32> %res2, <n x 4 x i32>* %out2
  ret void
}

define void @extract_wide_i64(<n x 4 x i64> %in, <n x 2 x i64>* %out1, <n x 2 x i64>* %out2) {
; CHECK-LABEL: extract_wide_i64:
; CHECK: ret
  %ec = elementcount <n x 2 x i64> zeroinitializer as i64
  %sv1 = seriesvector i64 0, 1 as <n x 2 x i64>
  %sv2 = seriesvector i64 %ec, 1 as <n x 2 x i64>
  %res1 = shufflevector <n x 4 x i64> %in, <n x 4 x i64> undef, <n x 2 x i64> %sv1
  %res2 = shufflevector <n x 4 x i64> %in, <n x 4 x i64> undef, <n x 2 x i64> %sv2
  store <n x 2 x i64> %res1, <n x 2 x i64>* %out1
  store <n x 2 x i64> %res2, <n x 2 x i64>* %out2
  ret void
}

define <n x 16 x i8> @extract_hi_half_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: extract_hi_half_i8:
; CHECK-NOT: lsr
; CHECK-NOT: uzp1
; CHECK: uzp2
; CHECK-NOT: uzp1
; CHECK: ret
  %zext_a = zext <n x 16 x i8> %a to <n x 16 x i16>
  %zext_b = zext <n x 16 x i8> %b to <n x 16 x i16>
  %add = add <n x 16 x i16> %zext_a, %zext_b
  %lsr = lshr <n x 16 x i16> %add, shufflevector (<n x 16 x i16> insertelement (<n x 16 x i16> undef, i16 8, i32 0),
                                                  <n x 16 x i16> undef,
                                                  <n x 16 x i16> zeroinitializer)
  %res = trunc <n x 16 x i16> %lsr to <n x 16 x i8>
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @extract_hi_half_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: extract_hi_half_i16:
; CHECK-NOT: lsr
; CHECK-NOT: uzp1
; CHECK: uzp2
; CHECK-NOT: uzp1
; CHECK: ret
  %zext_a = zext <n x 8 x i16> %a to <n x 8 x i32>
  %zext_b = zext <n x 8 x i16> %b to <n x 8 x i32>
  %add = add <n x 8 x i32> %zext_a, %zext_b
  %lsr = lshr <n x 8 x i32> %add, shufflevector (<n x 8 x i32> insertelement (<n x 8 x i32> undef, i32 16, i32 0),
                                                 <n x 8 x i32> undef,
                                                 <n x 8 x i32> zeroinitializer)
  %res = trunc <n x 8 x i32> %lsr to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @extract_hi_half_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: extract_hi_half_i32:
; CHECK-NOT: lsr
; CHECK-NOT: uzp1
; CHECK: uzp2
; CHECK-NOT: uzp1
; CHECK: ret
  %zext_a = zext <n x 4 x i32> %a to <n x 4 x i64>
  %zext_b = zext <n x 4 x i32> %b to <n x 4 x i64>
  %add = add <n x 4 x i64> %zext_a, %zext_b
  %lsr = lshr <n x 4 x i64> %add, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 32, i32 0),
                                                 <n x 4 x i64> undef,
                                                 <n x 4 x i64> zeroinitializer)
  %res = trunc <n x 4 x i64> %lsr to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

;; FP Concat

define <n x 4 x float> @concat_packed_float(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: concat_packed_float:
; CHECK: index [[MASK:z[0-9]+]].s, #0, #1
; CHECK: uzp1 z0.s, z0.s, z1.s
; CHECK: tbl z0.s, {z0.s}, [[MASK]].s
; CHECK: ret
  %sv  = seriesvector i32 0, 1 as <n x 4 x i32>
  %res = shufflevector <n x 2 x float> %a, <n x 2 x float> %b, <n x 4 x i32> %sv
  ret <n x 4 x float> %res
}

define <n x 8 x float> @concat_wide_float(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: concat_wide_float:
; CHECK: ret
  %sv  = seriesvector i32 0, 1 as <n x 8 x i32>
  %res = shufflevector <n x 4 x float> %a, <n x 4 x float> %b, <n x 8 x i32> %sv
  ret <n x 8 x float> %res
}

define <n x 4 x double> @concat_wide_double(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: concat_wide_double:
; CHECK: ret
  %sv  = seriesvector i64 0, 1 as <n x 4 x i64>
  %res = shufflevector <n x 2 x double> %a, <n x 2 x double> %b, <n x 4 x i64> %sv
  ret <n x 4 x double> %res
}

;; FP Extract

define void @extract_packed_float(<n x 4 x float> %in, <n x 2 x float>* %out1, <n x 2 x float>* %out2) {
; CHECK-LABEL: extract_packed_float:
; CHECK: uunpkhi [[MASK:z[0-9]+]].d, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.s, {{z[0-9]+}}.s, [[MASK]].s
; CHECK: uunpklo {{z[0-9]+}}.d, {{z[0-9]+}}.s
; CHECK: uunpklo {{z[0-9]+}}.d, {{z[0-9]+}}.s
; CHECK: ret
  %ec = elementcount <n x 2 x i32> zeroinitializer as i32
  %sv1 = seriesvector i32 0, 1 as <n x 2 x i32>
  %sv2 = seriesvector i32 %ec, 1 as <n x 2 x i32>
  %res1 = shufflevector <n x 4 x float> %in, <n x 4 x float> undef, <n x 2 x i32> %sv1
  %res2 = shufflevector <n x 4 x float> %in, <n x 4 x float> undef, <n x 2 x i32> %sv2
  store <n x 2 x float> %res1, <n x 2 x float>* %out1
  store <n x 2 x float> %res2, <n x 2 x float>* %out2
  ret void
}

define void @extract_wide_float(<n x 8 x float> %in, <n x 4 x float>* %out1, <n x 4 x float>* %out2) {
; CHECK-LABEL: extract_wide_float:
; CHECK: ret
  %ec = elementcount <n x 4 x i32> zeroinitializer as i32
  %sv1 = seriesvector i32 0, 1 as <n x 4 x i32>
  %sv2 = seriesvector i32 %ec, 1 as <n x 4 x i32>
  %res1 = shufflevector <n x 8 x float> %in, <n x 8 x float> undef, <n x 4 x i32> %sv1
  %res2 = shufflevector <n x 8 x float> %in, <n x 8 x float> undef, <n x 4 x i32> %sv2
  store <n x 4 x float> %res1, <n x 4 x float>* %out1
  store <n x 4 x float> %res2, <n x 4 x float>* %out2
  ret void
}

define void @extract_wide_double(<n x 4 x double> %in, <n x 2 x double>* %out1, <n x 2 x double>* %out2) {
; CHECK-LABEL: extract_wide_double:
; CHECK: ret
  %ec = elementcount <n x 2 x i64> zeroinitializer as i64
  %sv1 = seriesvector i64 0, 1 as <n x 2 x i64>
  %sv2 = seriesvector i64 %ec, 1 as <n x 2 x i64>
  %res1 = shufflevector <n x 4 x double> %in, <n x 4 x double> undef, <n x 2 x i64> %sv1
  %res2 = shufflevector <n x 4 x double> %in, <n x 4 x double> undef, <n x 2 x i64> %sv2
  store <n x 2 x double> %res1, <n x 2 x double>* %out1
  store <n x 2 x double> %res2, <n x 2 x double>* %out2
  ret void
}
