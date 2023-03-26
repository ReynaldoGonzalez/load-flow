/*
 * Load_Flow_Simulink_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Load_Flow_Simulink".
 *
 * Model version              : 11.11
 * Simulink Coder version : 9.4 (R2020b) 29-Jul-2020
 * C source code generated on : Tue Dec 27 02:31:11 2022
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: 32-bit Generic
 * Emulation hardware selection:
 *    Differs from embedded hardware (MATLAB Host)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Load_Flow_Simulink.h"
#include "Load_Flow_Simulink_private.h"

/* Block parameters (default storage) */
P_Load_Flow_Simulink_T Load_Flow_Simulink_P = {
  /* Mask Parameter: adjustreference_gain
   * Referenced by: '<S4>/Slider Gain'
   */
  93.5,

  /* Computed Parameter: OpComm_P1_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: nbport
   * Referenced by: '<S3>/OpComm'
   */
  3.0,

  /* Computed Parameter: OpComm_P2_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: st
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P3_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: groupe_acq
   * Referenced by: '<S3>/OpComm'
   */
  1.0,

  /* Computed Parameter: OpComm_P4_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Missed_Data
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P5_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Offset
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P6_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Sim_Time
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P7_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Samples
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P8_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: subsys_rate
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P9_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: dynSigOut
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P10_Size
   * Referenced by: '<S3>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: from_console
   * Referenced by: '<S3>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P1_Size_p
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: nbport
   * Referenced by: '<S5>/OpComm'
   */
  1.0,

  /* Computed Parameter: OpComm_P2_Size_b
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: st
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P3_Size_f
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: groupe_acq
   * Referenced by: '<S5>/OpComm'
   */
  1.0,

  /* Computed Parameter: OpComm_P4_Size_a
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Missed_Data
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P5_Size_h
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Offset
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P6_Size_p
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Sim_Time
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P7_Size_i
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: Samples
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P8_Size_m
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: subsys_rate
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P9_Size_a
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: dynSigOut
   * Referenced by: '<S5>/OpComm'
   */
  0.0,

  /* Computed Parameter: OpComm_P10_Size_n
   * Referenced by: '<S5>/OpComm'
   */
  { 1.0, 1.0 },

  /* Expression: from_console
   * Referenced by: '<S5>/OpComm'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<S1>/one'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<S2>/Constant'
   */
  1.0,

  /* Expression: 2
   * Referenced by: '<S2>/Constant1'
   */
  2.0,

  /* Expression: 3
   * Referenced by: '<S2>/Constant2'
   */
  3.0
};
