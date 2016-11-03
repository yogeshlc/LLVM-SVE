; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @add_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: add_b:
; CHECK: add z0.b, z{{[0-9]+}}.b, z{{[0-9]+}}.b
; CHECK: ret
  %res = add <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @add_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: add_h:
; CHECK: add z0.h, z{{[0-9]+}}.h, z{{[0-9]+}}.h
; CHECK: ret
  %res = add <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @add_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: add_s:
; CHECK: add z0.s, z{{[0-9]+}}.s, z{{[0-9]+}}.s
; CHECK: ret
  %res = add <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @add_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: add_d:
; CHECK: add z0.d, z{{[0-9]+}}.d, z{{[0-9]+}}.d
; CHECK: ret
  %res = add <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define void @mul_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: mul_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: mul [[RES:z[0-9]+]].b, [[PG]]/m, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = mul <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @mul_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: mul_h:
; CHECK:  ptrue [[PG:p[0-9]+]].h
; CHECK-DAG:  ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: mul [[RES:z[0-9]+]].h, [[PG]]/m, [[IN0]].h, [[IN1]].h
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = mul <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @mul_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: mul_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: mul [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = mul <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @mul_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: mul_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: mul [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = mul <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @sdiv_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: sdiv_b:
; CHECK-DAG: sunpkhi {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: sunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: sunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: trn1 {{z[0-9]+}}.b, {{z[0-9]+}}.b, {{z[0-9]+}}.b
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = sdiv <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @sdiv_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: sdiv_h:
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: sunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = sdiv <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @sdiv_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: sdiv_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: sdiv [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = sdiv <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @sdiv_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: sdiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: sdiv [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = sdiv <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @srem_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: srem_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: movprfx [[TMP:z[0-9]+]], [[IN0]]
; CHECK: sdiv [[TMP]].s, [[PG]]/m, [[TMP]].s, [[IN1]].s
; CHECK: mls [[IN0]].s, [[PG]]/m, [[TMP]].s, [[IN1]].s
; CHECK: st1w {[[IN0]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = srem <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @srem_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: srem_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: movprfx [[TMP:z[0-9]+]], [[IN0]]
; CHECK: sdiv [[TMP]].d, [[PG]]/m, [[TMP]].d, [[IN1]].d
; CHECK: mls [[IN0]].d, [[PG]]/m, [[TMP]].d, [[IN1]].d
; CHECK: st1d {[[IN0]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = srem <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @sub_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: sub_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK-DAG: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = sub <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @sub_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: sub_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK-DAG: sub [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = sub <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @sub_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: sub_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: sub [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = sub <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @sub_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: sub_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: sub [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = sub <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @udiv_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: udiv_b:
; CHECK-DAG: uunpkhi {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: uunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: trn1 {{z[0-9]+}}.b, {{z[0-9]+}}.b, {{z[0-9]+}}.b
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = udiv <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @udiv_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: udiv_h:
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: trn1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = udiv <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @udiv_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: udiv_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: udiv [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = udiv <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @udiv_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: udiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: udiv [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = udiv <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @urem_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: urem_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: movprfx [[TMP:z[0-9]+]], [[IN0]]
; CHECK: udiv [[TMP]].s, [[PG]]/m, [[TMP]].s, [[IN1]].s
; CHECK: mls [[IN0]].s, [[PG]]/m, [[TMP]].s, [[IN1]].s
; CHECK: st1w {[[IN0]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = urem <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @urem_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: urem_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: movprfx [[TMP:z[0-9]+]], [[IN0]]
; CHECK: udiv [[TMP]].d, [[PG]]/m, [[TMP]].d, [[IN1]].d
; CHECK: mls [[IN0]].d, [[PG]]/m, [[TMP]].d, [[IN1]].d
; CHECK: st1d {[[IN0]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = urem <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @and_bool2(<n x 2 x i1> *%a, <n x 2 x i1> *%b, <n x 2 x i1> *%c) {
; CHECK-LABEL: and_bool2:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].d
; CHECK:      and [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 2 x i1> , <n x 2 x i1> *%b
  %in1 = load <n x 2 x i1> , <n x 2 x i1> *%c
  %res = and <n x 2 x i1> %in0, %in1
  store <n x 2 x i1> %res, <n x 2 x i1> *%a
  ret void
}

define void @and_bool4(<n x 4 x i1> *%a, <n x 4 x i1> *%b, <n x 4 x i1> *%c) {
; CHECK-LABEL: and_bool4:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].s
; CHECK:      and [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 4 x i1> , <n x 4 x i1> *%b
  %in1 = load <n x 4 x i1> , <n x 4 x i1> *%c
  %res = and <n x 4 x i1> %in0, %in1
  store <n x 4 x i1> %res, <n x 4 x i1> *%a
  ret void
}

define void @and_bool8(<n x 8 x i1> *%a, <n x 8 x i1> *%b, <n x 8 x i1> *%c) {
; CHECK-LABEL: and_bool8:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].h
; CHECK:      and [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 8 x i1> , <n x 8 x i1> *%b
  %in1 = load <n x 8 x i1> , <n x 8 x i1> *%c
  %res = and <n x 8 x i1> %in0, %in1
  store <n x 8 x i1> %res, <n x 8 x i1> *%a
  ret void
}

define void @and_bool16(<n x 16 x i1> *%a, <n x 16 x i1> *%b, <n x 16 x i1> *%c) {
; CHECK-LABEL: and_bool16:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].b
; CHECK:      and [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 16 x i1> , <n x 16 x i1> *%b
  %in1 = load <n x 16 x i1> , <n x 16 x i1> *%c
  %res = and <n x 16 x i1> %in0, %in1
  store <n x 16 x i1> %res, <n x 16 x i1> *%a
  ret void
}

define void @and_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: and_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK-DAG: and [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = and <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @and_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: and_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK-DAG: and [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = and <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @and_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: and_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: and [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = and <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @and_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: and_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: and [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = and <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @or_bool2(<n x 2 x i1> *%a, <n x 2 x i1> *%b, <n x 2 x i1> *%c) {
; CHECK-LABEL: or_bool2:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].d
; CHECK:      orr [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 2 x i1> , <n x 2 x i1> *%b
  %in1 = load <n x 2 x i1> , <n x 2 x i1> *%c
  %res = or <n x 2 x i1> %in0, %in1
  store <n x 2 x i1> %res, <n x 2 x i1> *%a
  ret void
}

define void @or_bool4(<n x 4 x i1> *%a, <n x 4 x i1> *%b, <n x 4 x i1> *%c) {
; CHECK-LABEL: or_bool4:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].s
; CHECK:      orr [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 4 x i1> , <n x 4 x i1> *%b
  %in1 = load <n x 4 x i1> , <n x 4 x i1> *%c
  %res = or <n x 4 x i1> %in0, %in1
  store <n x 4 x i1> %res, <n x 4 x i1> *%a
  ret void
}

define void @or_bool8(<n x 8 x i1> *%a, <n x 8 x i1> *%b, <n x 8 x i1> *%c) {
; CHECK-LABEL: or_bool8:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].h
; CHECK:      orr [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 8 x i1> , <n x 8 x i1> *%b
  %in1 = load <n x 8 x i1> , <n x 8 x i1> *%c
  %res = or <n x 8 x i1> %in0, %in1
  store <n x 8 x i1> %res, <n x 8 x i1> *%a
  ret void
}

define void @or_bool16(<n x 16 x i1> *%a, <n x 16 x i1> *%b, <n x 16 x i1> *%c) {
; CHECK-LABEL: or_bool16:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].b
; CHECK:      orr [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 16 x i1> , <n x 16 x i1> *%b
  %in1 = load <n x 16 x i1> , <n x 16 x i1> *%c
  %res = or <n x 16 x i1> %in0, %in1
  store <n x 16 x i1> %res, <n x 16 x i1> *%a
  ret void
}

define void @or_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: or_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK-DAG: orr [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = or <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @or_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: or_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK-DAG: orr [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = or <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @or_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: or_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: orr [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = or <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @or_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: or_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: orr [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = or <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @xor_bool2(<n x 2 x i1> *%a, <n x 2 x i1> *%b, <n x 2 x i1> *%c) {
; CHECK-LABEL: xor_bool2:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].d
; CHECK:      eor [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 2 x i1> , <n x 2 x i1> *%b
  %in1 = load <n x 2 x i1> , <n x 2 x i1> *%c
  %res = xor <n x 2 x i1> %in0, %in1
  store <n x 2 x i1> %res, <n x 2 x i1> *%a
  ret void
}

define void @xor_bool4(<n x 4 x i1> *%a, <n x 4 x i1> *%b, <n x 4 x i1> *%c) {
; CHECK-LABEL: xor_bool4:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].s
; CHECK:      eor [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 4 x i1> , <n x 4 x i1> *%b
  %in1 = load <n x 4 x i1> , <n x 4 x i1> *%c
  %res = xor <n x 4 x i1> %in0, %in1
  store <n x 4 x i1> %res, <n x 4 x i1> *%a
  ret void
}

define void @xor_bool8(<n x 8 x i1> *%a, <n x 8 x i1> *%b, <n x 8 x i1> *%c) {
; CHECK-LABEL: xor_bool8:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].h
; CHECK:      eor [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 8 x i1> , <n x 8 x i1> *%b
  %in1 = load <n x 8 x i1> , <n x 8 x i1> *%c
  %res = xor <n x 8 x i1> %in0, %in1
  store <n x 8 x i1> %res, <n x 8 x i1> *%a
  ret void
}

define void @xor_bool16(<n x 16 x i1> *%a, <n x 16 x i1> *%b, <n x 16 x i1> *%c) {
; CHECK-LABEL: xor_bool16:
; CHECK-DAG:  ldr [[IN0:p[0-9]+]], [x1]
; CHECK-DAG:  ldr [[IN1:p[0-9]+]], [x2]
; CHECK-DAG:  ptrue [[PG:p[0-9]+]].b
; CHECK:      eor [[RES:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: str [[RES]],
; CHECK:      ret
  %in0 = load <n x 16 x i1> , <n x 16 x i1> *%b
  %in1 = load <n x 16 x i1> , <n x 16 x i1> *%c
  %res = xor <n x 16 x i1> %in0, %in1
  store <n x 16 x i1> %res, <n x 16 x i1> *%a
  ret void
}

define void @xor_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: xor_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK-DAG: eor [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = xor <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @xor_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: xor_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK-DAG: eor [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = xor <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @xor_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: xor_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: eor [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = xor <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @xor_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: xor_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: eor [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = xor <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @add_pred_b(<n x 16 x i1> *%p, <n x 16 x i8> *%a,
                        <n x 16 x i8> *%b) {
; CHECK-LABEL: add_pred_b:
; CHECK-NOT: sel
; CHECK: add {{z[0-9]+}}.b, {{p[0-9]+}}/m
  %gp = load <n x 16 x i1> , <n x 16 x i1> *%p
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %toadd = select <n x 16 x i1> %gp, <n x 16 x i8> %in0, <n x 16 x i8> zeroinitializer
  %res = add <n x 16 x i8> %in1, %toadd
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @sub_pred_h(<n x 8 x i1> *%p, <n x 8 x i16> *%a,
                        <n x 8 x i16> *%b) {
; CHECK-LABEL: sub_pred_h:
; CHECK-NOT: sel
; CHECK: sub{{r?}} {{z[0-9]+}}.h, {{p[0-9]+}}/m
  %gp = load <n x 8 x i1> , <n x 8 x i1> *%p
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %tosub = select <n x 8 x i1> %gp, <n x 8 x i16> %in0, <n x 8 x i16> zeroinitializer
  %res = sub <n x 8 x i16> %in1, %tosub
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @add_pred_s(<n x 4 x i1> *%p, <n x 4 x i32> *%a,
                        <n x 4 x i32> *%b) {
; CHECK-LABEL: add_pred_s:
; CHECK-NOT: sel
; CHECK: add {{z[0-9]+}}.s, {{p[0-9]+}}/m
  %gp = load <n x 4 x i1> , <n x 4 x i1> *%p
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %toadd = select <n x 4 x i1> %gp, <n x 4 x i32> %in0, <n x 4 x i32> zeroinitializer
  %res = add <n x 4 x i32> %in1, %toadd
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @sub_pred_d(<n x 2 x i1> *%p, <n x 2 x i64> *%a,
                        <n x 2 x i64> *%b) {
; CHECK-LABEL: sub_pred_d:
; CHECK-NOT: sel
; CHECK: sub{{r?}} {{z[0-9]+}}.d, {{p[0-9]+}}/m
  %gp = load <n x 2 x i1> , <n x 2 x i1> *%p
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %tosub = select <n x 2 x i1> %gp, <n x 2 x i64> %in0, <n x 2 x i64> zeroinitializer
  %res = sub <n x 2 x i64> %in1, %tosub
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}
