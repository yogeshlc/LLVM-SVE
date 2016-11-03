; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @ashr_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: ashr_b:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK:      asr [[RES:z[0-9]+]].b, [[PG]]/m, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = ashr <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @ashr_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: ashr_h:
; CHECK:  ptrue [[PG:p[0-9]+]].h
; CHECK-DAG:  ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK:      asr [[RES:z[0-9]+]].h, [[PG]]/m, [[IN0]].h, [[IN1]].h
; CHECK-NEXT: st1h {[[RES]].h},
; CHECK:      ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = ashr <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @ashr_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: ashr_s:
; CHECK:  ptrue [[PG:p[0-9]+]].s
; CHECK-DAG:  ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK:      asr [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK-NEXT: st1w {[[RES]].s},
; CHECK:      ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = ashr <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @ashr_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: ashr_d:
; CHECK:  ptrue [[PG:p[0-9]+]].d
; CHECK-DAG:  ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK:      asr [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK-NEXT: st1d {[[RES]].d},
; CHECK:      ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = ashr <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @ashr_cpy(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c,
                      <n x 16 x i8> *%d, <n x 16 x i8> *%e) {
; CHECK-LABEL: ashr_cpy:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x3]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x4]
; CHECK-DAG:  mov [[CPY:z[0-9]+]].d, [[IN0]].d
; CHECK:      asr [[RES:z[0-9]+]].b, [[PG]]/m, [[CPY]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load volatile <n x 16 x i8> , <n x 16 x i8> *%d
  %in1 = load volatile <n x 16 x i8> , <n x 16 x i8> *%e
  %res = ashr <n x 16 x i8> %in0, %in1
  store volatile <n x 16 x i8> %res, <n x 16 x i8> *%a
  ; keep the original data live, thus introducing a copy
  store volatile <n x 16 x i8> %in0, <n x 16 x i8> *%b
  store volatile <n x 16 x i8> %in1, <n x 16 x i8> *%c
  ret void
}

define void @lshr_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: lshr_b:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK:      lsr [[RES:z[0-9]+]].b, [[PG]]/m, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = lshr <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @lshr_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: lshr_h:
; CHECK:  ptrue [[PG:p[0-9]+]].h
; CHECK-DAG:  ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK:      lsr [[RES:z[0-9]+]].h, [[PG]]/m, [[IN0]].h, [[IN1]].h
; CHECK-NEXT: st1h {[[RES]].h},
; CHECK:      ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = lshr <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @lshr_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: lshr_s:
; CHECK:  ptrue [[PG:p[0-9]+]].s
; CHECK-DAG:  ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK:      lsr [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK-NEXT: st1w {[[RES]].s},
; CHECK:      ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = lshr <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @lshr_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: lshr_d:
; CHECK:  ptrue [[PG:p[0-9]+]].d
; CHECK-DAG:  ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK:      lsr [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK-NEXT: st1d {[[RES]].d},
; CHECK:      ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = lshr <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @lshr_cpy(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c,
                      <n x 16 x i8> *%d, <n x 16 x i8> *%e) {
; CHECK-LABEL: lshr_cpy:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x3]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x4]
; CHECK-DAG:  mov [[CPY:z[0-9]+]].d, [[IN0]].d
; CHECK:      lsr [[RES:z[0-9]+]].b, [[PG]]/m, [[CPY]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load volatile <n x 16 x i8> , <n x 16 x i8> *%d
  %in1 = load volatile <n x 16 x i8> , <n x 16 x i8> *%e
  %res = lshr <n x 16 x i8> %in0, %in1
  store volatile <n x 16 x i8> %res, <n x 16 x i8> *%a
  ; keep the original data live, thus introducing a copy
  store volatile <n x 16 x i8> %in0, <n x 16 x i8> *%b
  store volatile <n x 16 x i8> %in1, <n x 16 x i8> *%c
  ret void
}

define void @shl_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: shl_b:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK:      lsl [[RES:z[0-9]+]].b, [[PG]]/m, [[IN0]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = shl <n x 16 x i8> %in0, %in1
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @shl_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: shl_h:
; CHECK:  ptrue [[PG:p[0-9]+]].h
; CHECK-DAG:  ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK:      lsl [[RES:z[0-9]+]].h, [[PG]]/m, [[IN0]].h, [[IN1]].h
; CHECK-NEXT: st1h {[[RES]].h},
; CHECK:      ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = shl <n x 8 x i16> %in0, %in1
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @shl_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: shl_s:
; CHECK:  ptrue [[PG:p[0-9]+]].s
; CHECK-DAG:  ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK:      lsl [[RES:z[0-9]+]].s, [[PG]]/m, [[IN0]].s, [[IN1]].s
; CHECK-NEXT: st1w {[[RES]].s},
; CHECK:      ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = shl <n x 4 x i32> %in0, %in1
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @shl_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: shl_d:
; CHECK:  ptrue [[PG:p[0-9]+]].d
; CHECK-DAG:  ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG:  ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK:      lsl [[RES:z[0-9]+]].d, [[PG]]/m, [[IN0]].d, [[IN1]].d
; CHECK-NEXT: st1d {[[RES]].d},
; CHECK:      ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = shl <n x 2 x i64> %in0, %in1
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @shl_cpy(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c,
                     <n x 16 x i8> *%d, <n x 16 x i8> *%e) {
; CHECK-LABEL: shl_cpy:
; CHECK:  ptrue [[PG:p[0-9]+]].b
; CHECK-DAG:  ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x3]
; CHECK-DAG:  ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x4]
; CHECK-DAG:  mov [[CPY:z[0-9]+]].d, [[IN0]].d
; CHECK:      lsl [[RES:z[0-9]+]].b, [[PG]]/m, [[CPY]].b, [[IN1]].b
; CHECK-NEXT: st1b {[[RES]].b},
; CHECK:      ret
  %in0 = load volatile <n x 16 x i8> , <n x 16 x i8> *%d
  %in1 = load volatile <n x 16 x i8> , <n x 16 x i8> *%e
  %res = shl <n x 16 x i8> %in0, %in1
  store volatile <n x 16 x i8> %res, <n x 16 x i8> *%a
  ; keep the original data live, thus introducing a copy
  store volatile <n x 16 x i8> %in0, <n x 16 x i8> *%b
  store volatile <n x 16 x i8> %in1, <n x 16 x i8> *%c
  ret void
}
