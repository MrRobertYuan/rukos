typedef unsigned int fpu_control_t;
#define _FPU_GETCW(cw) (cw) = 0
#define _FPU_SETCW(cw) (void) (cw)
#define _FPU_FPCR_RM_MASK  0xc00000

#define FE_INVALID	  1
#define FE_DIVBYZERO	2
#define FE_OVERFLOW	  4
#define FE_UNDERFLOW	8
#define FE_INEXACT	  16

#define FE_TONEAREST  0x000000
#define FE_UPWARD     0x400000
#define FE_DOWNWARD   0x800000
#define FE_TOWARDZERO 0xc00000

#define FE_EXCEPT_SHIFT	8

#define FE_ALL_EXCEPT	\
	(FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW | FE_UNDERFLOW | FE_INEXACT)

#define __BITS4 (W_TYPE_SIZE / 4)
#define __ll_B ((UWtype) 1 << (W_TYPE_SIZE / 2))
#define __ll_lowpart(t) ((UWtype) (t) & (__ll_B - 1))
#define __ll_highpart(t) ((UWtype) (t) >> (W_TYPE_SIZE / 2))

#if !defined (add_ssaaaa)
#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
  do {									\
    UWtype __x;								\
    __x = (al) + (bl);							\
    (sh) = (ah) + (bh) + (__x < (al));					\
    (sl) = __x;								\
  } while (0)
#endif

#if !defined (sub_ddmmss)
#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
  do {									\
    UWtype __x;								\
    __x = (al) - (bl);							\
    (sh) = (ah) - (bh) - (__x > (al));					\
    (sl) = __x;								\
  } while (0)
#endif

/* If we lack umul_ppmm but have smul_ppmm, define umul_ppmm in terms of
   smul_ppmm.  */
#if !defined (umul_ppmm) && defined (smul_ppmm)
#define umul_ppmm(w1, w0, u, v)						\
  do {									\
    UWtype __w1;							\
    UWtype __xm0 = (u), __xm1 = (v);					\
    smul_ppmm (__w1, w0, __xm0, __xm1);					\
    (w1) = __w1 + (-(__xm0 >> (W_TYPE_SIZE - 1)) & __xm1)		\
		+ (-(__xm1 >> (W_TYPE_SIZE - 1)) & __xm0);		\
  } while (0)
#endif

/* If we still don't have umul_ppmm, define it using plain C.  */
#if !defined (umul_ppmm)
#define umul_ppmm(w1, w0, u, v)						\
  do {									\
    UWtype __x0, __x1, __x2, __x3;					\
    UHWtype __ul, __vl, __uh, __vh;					\
									\
    __ul = __ll_lowpart (u);						\
    __uh = __ll_highpart (u);						\
    __vl = __ll_lowpart (v);						\
    __vh = __ll_highpart (v);						\
									\
    __x0 = (UWtype) __ul * __vl;					\
    __x1 = (UWtype) __ul * __vh;					\
    __x2 = (UWtype) __uh * __vl;					\
    __x3 = (UWtype) __uh * __vh;					\
									\
    __x1 += __ll_highpart (__x0);/* this can't give carry */		\
    __x1 += __x2;		/* but this indeed can */		\
    if (__x1 < __x2)		/* did we get it? */			\
      __x3 += __ll_B;		/* yes, add it in the proper pos.  */	\
									\
    (w1) = __x3 + __ll_highpart (__x1);					\
    (w0) = __ll_lowpart (__x1) * __ll_B + __ll_lowpart (__x0);		\
  } while (0)
#endif


/* Define this unconditionally, so it can be used for debugging.  */
#define __udiv_qrnnd_c(q, r, n1, n0, d) \
  do {									\
    UWtype __d1, __d0, __q1, __q0;					\
    UWtype __r1, __r0, __m;						\
    __d1 = __ll_highpart (d);						\
    __d0 = __ll_lowpart (d);						\
									\
    __r1 = (n1) % __d1;							\
    __q1 = (n1) / __d1;							\
    __m = (UWtype) __q1 * __d0;						\
    __r1 = __r1 * __ll_B | __ll_highpart (n0);				\
    if (__r1 < __m)							\
      {									\
	__q1--, __r1 += (d);						\
	if (__r1 >= (d)) /* i.e. we didn't get carry when adding to __r1 */\
	  if (__r1 < __m)						\
	    __q1--, __r1 += (d);					\
      }									\
    __r1 -= __m;							\
									\
    __r0 = __r1 % __d1;							\
    __q0 = __r1 / __d1;							\
    __m = (UWtype) __q0 * __d0;						\
    __r0 = __r0 * __ll_B | __ll_lowpart (n0);				\
    if (__r0 < __m)							\
      {									\
	__q0--, __r0 += (d);						\
	if (__r0 >= (d))						\
	  if (__r0 < __m)						\
	    __q0--, __r0 += (d);					\
      }									\
    __r0 -= __m;							\
									\
    (q) = (UWtype) __q1 * __ll_B | __q0;				\
    (r) = __r0;								\
  } while (0)

/* If the processor has no udiv_qrnnd but sdiv_qrnnd, go through
   __udiv_w_sdiv (defined in libgcc or elsewhere).  */
#if !defined (udiv_qrnnd) && defined (sdiv_qrnnd)
#define udiv_qrnnd(q, r, nh, nl, d) \
  do {									\
    extern UWtype __udiv_w_sdiv (UWtype *, UWtype, UWtype, UWtype);	\
    UWtype __r;								\
    (q) = __udiv_w_sdiv (&__r, nh, nl, d);				\
    (r) = __r;								\
  } while (0)
#endif

/* If udiv_qrnnd was not defined for this processor, use __udiv_qrnnd_c.  */
#if !defined (udiv_qrnnd)
#define UDIV_NEEDS_NORMALIZATION 1
#define udiv_qrnnd __udiv_qrnnd_c
#endif

#define _FP_W_TYPE_SIZE		64
#define _FP_W_TYPE		unsigned long long
#define _FP_WS_TYPE		signed long long
#define _FP_I_TYPE		long long

#define _FP_MUL_MEAT_S(R,X,Y)					\
  _FP_MUL_MEAT_1_imm(_FP_WFRACBITS_S,R,X,Y)
#define _FP_MUL_MEAT_D(R,X,Y)					\
  _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
#define _FP_MUL_MEAT_Q(R,X,Y)					\
  _FP_MUL_MEAT_2_wide_3mul(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)

#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_imm(S,R,X,Y,_FP_DIV_HELP_imm)
#define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(D,R,X,Y)
#define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_2_udiv(Q,R,X,Y)

#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1)
#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1
#define _FP_NANSIGN_S		0
#define _FP_NANSIGN_D		0
#define _FP_NANSIGN_Q		0

#define _FP_KEEPNANFRACP 1
#define _FP_QNANNEGATEDP 0

/* From my experiments it seems X is chosen unless one of the
   NaNs is sNaN,  in which case the result is NANSIGN/NANFRAC.  */
#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
  do {								\
    if ((_FP_FRAC_HIGH_RAW_##fs(X)				\
	 | _FP_FRAC_HIGH_RAW_##fs(Y)) & _FP_QNANBIT_##fs)	\
      {								\
	R##_s = _FP_NANSIGN_##fs;				\
        _FP_FRAC_SET_##wc(R,_FP_NANFRAC_##fs);			\
      }								\
    else							\
      {								\
	R##_s = X##_s;						\
        _FP_FRAC_COPY_##wc(R,X);				\
      }								\
    R##_c = FP_CLS_NAN;						\
  } while (0)

#define _FP_DECL_EX		fpu_control_t _fcw

#define FP_ROUNDMODE		(_fcw & _FPU_FPCR_RM_MASK)

#define FP_RND_NEAREST		FE_TONEAREST
#define FP_RND_ZERO		FE_TOWARDZERO
#define FP_RND_PINF		FE_UPWARD
#define FP_RND_MINF		FE_DOWNWARD

#define FP_EX_INVALID		FE_INVALID
#define FP_EX_OVERFLOW		FE_OVERFLOW
#define FP_EX_UNDERFLOW		FE_UNDERFLOW
#define FP_EX_DIVZERO		FE_DIVBYZERO
#define FP_EX_INEXACT		FE_INEXACT

#define _FP_TININESS_AFTER_ROUNDING 0

#define FP_INIT_ROUNDMODE			\
do {						\
  _FPU_GETCW (_fcw);				\
} while (0)

#define FP_HANDLE_EXCEPTIONS						\
  do {									\
    const float fp_max = __FLT_MAX__;					\
    const float fp_min = __FLT_MIN__;					\
    const float fp_1e32 = 1.0e32f;					\
    const float fp_zero = 0.0;						\
    const float fp_one = 1.0;						\
    unsigned fpsr;							\
    if (_fex & FP_EX_INVALID)						\
      {									\
        __asm__ __volatile__ ("fdiv\ts0, %s0, %s0"			\
			      :						\
			      : "w" (fp_zero)				\
			      : "s0");					\
	__asm__ __volatile__ ("mrs\t%0, fpsr" : "=r" (fpsr));		\
      }									\
    if (_fex & FP_EX_DIVZERO)						\
      {									\
	__asm__ __volatile__ ("fdiv\ts0, %s0, %s1"			\
			      :						\
			      : "w" (fp_one), "w" (fp_zero)		\
			      : "s0");					\
	__asm__ __volatile__ ("mrs\t%0, fpsr" : "=r" (fpsr));		\
      }									\
    if (_fex & FP_EX_OVERFLOW)						\
      {									\
        __asm__ __volatile__ ("fadd\ts0, %s0, %s1"			\
			      :						\
			      : "w" (fp_max), "w" (fp_1e32)		\
			      : "s0");					\
        __asm__ __volatile__ ("mrs\t%0, fpsr" : "=r" (fpsr));		\
      }									\
    if (_fex & FP_EX_UNDERFLOW)						\
      {									\
	__asm__ __volatile__ ("fmul\ts0, %s0, %s0"			\
			      :						\
			      : "w" (fp_min)				\
			      : "s0");					\
	__asm__ __volatile__ ("mrs\t%0, fpsr" : "=r" (fpsr));		\
      }									\
    if (_fex & FP_EX_INEXACT)						\
      {									\
	__asm__ __volatile__ ("fsub\ts0, %s0, %s1"			\
			      :						\
			      : "w" (fp_max), "w" (fp_one)		\
			      : "s0");					\
	__asm__ __volatile__ ("mrs\t%0, fpsr" : "=r" (fpsr));		\
      }									\
  } while (0)

#define FP_TRAPPING_EXCEPTIONS ((_fcw >> FE_EXCEPT_SHIFT) & FE_ALL_EXCEPT)
