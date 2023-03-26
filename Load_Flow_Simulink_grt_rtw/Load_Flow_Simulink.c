/*
 * Load_Flow_Simulink.c
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

/* Block signals (default storage) */
B_Load_Flow_Simulink_T Load_Flow_Simulink_B;

/* Block states (default storage) */
DW_Load_Flow_Simulink_T Load_Flow_Simulink_DW;

/* Real-time model */
static RT_MODEL_Load_Flow_Simulink_T Load_Flow_Simulink_M_;
RT_MODEL_Load_Flow_Simulink_T *const Load_Flow_Simulink_M =
  &Load_Flow_Simulink_M_;

/* Model output function */
static void Load_Flow_Simulink_output(void)
{
  /* Gain: '<S4>/Slider Gain' incorporates:
   *  Constant: '<S1>/one'
   */
  Load_Flow_Simulink_B.SliderGain = Load_Flow_Simulink_P.adjustreference_gain *
    Load_Flow_Simulink_P.one_Value;

  /* Outputs for Atomic SubSystem: '<S1>/OpComm' */
  /* Inport: '<S3>/In1' incorporates:
   *  Constant: '<S2>/Constant'
   */
  Load_Flow_Simulink_B.In1_m = Load_Flow_Simulink_P.Constant_Value;

  /* Inport: '<S3>/In2' incorporates:
   *  Constant: '<S2>/Constant1'
   */
  Load_Flow_Simulink_B.In2 = Load_Flow_Simulink_P.Constant1_Value;

  /* Inport: '<S3>/In3' incorporates:
   *  Constant: '<S2>/Constant2'
   */
  Load_Flow_Simulink_B.In3 = Load_Flow_Simulink_P.Constant2_Value;

  /* DigitalClock: '<S3>/Cte' */
  Load_Flow_Simulink_B.Cte = Load_Flow_Simulink_M->Timing.t[0];

  /* S-Function (sfun_rtlab_comm): '<S3>/OpComm' */

  /* Level2 S-Function Block: '<S3>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[0];
    sfcnOutputs(rts,0);
  }

  /* End of Outputs for SubSystem: '<S1>/OpComm' */
  /* Outputs for Atomic SubSystem: '<S2>/OpComm' */
  /* Inport: '<S5>/In1' */
  Load_Flow_Simulink_B.In1 = Load_Flow_Simulink_B.SliderGain;

  /* S-Function (sfun_rtlab_comm): '<S5>/OpComm' */

  /* Level2 S-Function Block: '<S5>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[1];
    sfcnOutputs(rts,0);
  }

  /* End of Outputs for SubSystem: '<S2>/OpComm' */
}

/* Model update function */
static void Load_Flow_Simulink_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++Load_Flow_Simulink_M->Timing.clockTick0)) {
    ++Load_Flow_Simulink_M->Timing.clockTickH0;
  }

  Load_Flow_Simulink_M->Timing.t[0] = Load_Flow_Simulink_M->Timing.clockTick0 *
    Load_Flow_Simulink_M->Timing.stepSize0 +
    Load_Flow_Simulink_M->Timing.clockTickH0 *
    Load_Flow_Simulink_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
static void Load_Flow_Simulink_initialize(void)
{
  /* Start for Atomic SubSystem: '<S1>/OpComm' */

  /* Start for S-Function (sfun_rtlab_comm): '<S3>/OpComm' */
  /* Level2 S-Function Block: '<S3>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[0];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* End of Start for SubSystem: '<S1>/OpComm' */

  /* Start for Atomic SubSystem: '<S2>/OpComm' */

  /* Start for S-Function (sfun_rtlab_comm): '<S5>/OpComm' */
  /* Level2 S-Function Block: '<S5>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[1];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* End of Start for SubSystem: '<S2>/OpComm' */

  /* SystemInitialize for Atomic SubSystem: '<S1>/OpComm' */

  /* InitializeConditions for S-Function (sfun_rtlab_comm): '<S3>/OpComm' */
  /* Level2 S-Function Block: '<S3>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[0];
    sfcnInitializeConditions(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* End of SystemInitialize for SubSystem: '<S1>/OpComm' */

  /* SystemInitialize for Atomic SubSystem: '<S2>/OpComm' */

  /* InitializeConditions for S-Function (sfun_rtlab_comm): '<S5>/OpComm' */
  /* Level2 S-Function Block: '<S5>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[1];
    sfcnInitializeConditions(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* End of SystemInitialize for SubSystem: '<S2>/OpComm' */
}

/* Model terminate function */
static void Load_Flow_Simulink_terminate(void)
{
  /* Terminate for Atomic SubSystem: '<S1>/OpComm' */

  /* Terminate for S-Function (sfun_rtlab_comm): '<S3>/OpComm' */
  /* Level2 S-Function Block: '<S3>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[0];
    sfcnTerminate(rts);
  }

  /* End of Terminate for SubSystem: '<S1>/OpComm' */

  /* Terminate for Atomic SubSystem: '<S2>/OpComm' */

  /* Terminate for S-Function (sfun_rtlab_comm): '<S5>/OpComm' */
  /* Level2 S-Function Block: '<S5>/OpComm' (sfun_rtlab_comm) */
  {
    SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[1];
    sfcnTerminate(rts);
  }

  /* End of Terminate for SubSystem: '<S2>/OpComm' */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  Load_Flow_Simulink_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  Load_Flow_Simulink_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  Load_Flow_Simulink_initialize();
}

void MdlTerminate(void)
{
  Load_Flow_Simulink_terminate();
}

/* Registration function */
RT_MODEL_Load_Flow_Simulink_T *Load_Flow_Simulink(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)Load_Flow_Simulink_M, 0,
                sizeof(RT_MODEL_Load_Flow_Simulink_T));
  rtsiSetSolverName(&Load_Flow_Simulink_M->solverInfo,"FixedStepDiscrete");
  Load_Flow_Simulink_M->solverInfoPtr = (&Load_Flow_Simulink_M->solverInfo);

  /* Initialize timing info */
  {
    int_T *mdlTsMap = Load_Flow_Simulink_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    Load_Flow_Simulink_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    Load_Flow_Simulink_M->Timing.sampleTimes =
      (&Load_Flow_Simulink_M->Timing.sampleTimesArray[0]);
    Load_Flow_Simulink_M->Timing.offsetTimes =
      (&Load_Flow_Simulink_M->Timing.offsetTimesArray[0]);

    /* task periods */
    Load_Flow_Simulink_M->Timing.sampleTimes[0] = (0.001);

    /* task offsets */
    Load_Flow_Simulink_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(Load_Flow_Simulink_M, &Load_Flow_Simulink_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = Load_Flow_Simulink_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    Load_Flow_Simulink_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(Load_Flow_Simulink_M, -1);
  Load_Flow_Simulink_M->Timing.stepSize0 = 0.001;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    Load_Flow_Simulink_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(Load_Flow_Simulink_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(Load_Flow_Simulink_M->rtwLogInfo, (NULL));
    rtliSetLogT(Load_Flow_Simulink_M->rtwLogInfo, "");
    rtliSetLogX(Load_Flow_Simulink_M->rtwLogInfo, "");
    rtliSetLogXFinal(Load_Flow_Simulink_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(Load_Flow_Simulink_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(Load_Flow_Simulink_M->rtwLogInfo, 0);
    rtliSetLogMaxRows(Load_Flow_Simulink_M->rtwLogInfo, 1000);
    rtliSetLogDecimation(Load_Flow_Simulink_M->rtwLogInfo, 1);
    rtliSetLogY(Load_Flow_Simulink_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(Load_Flow_Simulink_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(Load_Flow_Simulink_M->rtwLogInfo, (NULL));
  }

  Load_Flow_Simulink_M->solverInfoPtr = (&Load_Flow_Simulink_M->solverInfo);
  Load_Flow_Simulink_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&Load_Flow_Simulink_M->solverInfo, 0.001);
  rtsiSetSolverMode(&Load_Flow_Simulink_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  Load_Flow_Simulink_M->blockIO = ((void *) &Load_Flow_Simulink_B);

  {
    Load_Flow_Simulink_B.SliderGain = 0.0;
    Load_Flow_Simulink_B.In1 = 0.0;
    Load_Flow_Simulink_B.MissedData = 0.0;
    Load_Flow_Simulink_B.Offset = 0.0;
    Load_Flow_Simulink_B.SimTime = 0.0;
    Load_Flow_Simulink_B.SampleSec = 0.0;
    Load_Flow_Simulink_B.DynamicSignals = 0.0;
    Load_Flow_Simulink_B.In1_m = 0.0;
    Load_Flow_Simulink_B.In2 = 0.0;
    Load_Flow_Simulink_B.In3 = 0.0;
    Load_Flow_Simulink_B.Cte = 0.0;
    Load_Flow_Simulink_B.MissedData_b = 0.0;
    Load_Flow_Simulink_B.Offset_d = 0.0;
    Load_Flow_Simulink_B.SimTime_e = 0.0;
    Load_Flow_Simulink_B.SampleSec_f = 0.0;
    Load_Flow_Simulink_B.DynamicSignals_e = 0.0;
  }

  /* parameters */
  Load_Flow_Simulink_M->defaultParam = ((real_T *)&Load_Flow_Simulink_P);

  /* states (dwork) */
  Load_Flow_Simulink_M->dwork = ((void *) &Load_Flow_Simulink_DW);
  (void) memset((void *)&Load_Flow_Simulink_DW, 0,
                sizeof(DW_Load_Flow_Simulink_T));

  /* child S-Function registration */
  {
    RTWSfcnInfo *sfcnInfo = &Load_Flow_Simulink_M->NonInlinedSFcns.sfcnInfo;
    Load_Flow_Simulink_M->sfcnInfo = (sfcnInfo);
    rtssSetErrorStatusPtr(sfcnInfo, (&rtmGetErrorStatus(Load_Flow_Simulink_M)));
    rtssSetNumRootSampTimesPtr(sfcnInfo,
      &Load_Flow_Simulink_M->Sizes.numSampTimes);
    Load_Flow_Simulink_M->NonInlinedSFcns.taskTimePtrs[0] = &(rtmGetTPtr
      (Load_Flow_Simulink_M)[0]);
    rtssSetTPtrPtr(sfcnInfo,Load_Flow_Simulink_M->NonInlinedSFcns.taskTimePtrs);
    rtssSetTStartPtr(sfcnInfo, &rtmGetTStart(Load_Flow_Simulink_M));
    rtssSetTFinalPtr(sfcnInfo, &rtmGetTFinal(Load_Flow_Simulink_M));
    rtssSetTimeOfLastOutputPtr(sfcnInfo, &rtmGetTimeOfLastOutput
      (Load_Flow_Simulink_M));
    rtssSetStepSizePtr(sfcnInfo, &Load_Flow_Simulink_M->Timing.stepSize);
    rtssSetStopRequestedPtr(sfcnInfo, &rtmGetStopRequested(Load_Flow_Simulink_M));
    rtssSetDerivCacheNeedsResetPtr(sfcnInfo,
      &Load_Flow_Simulink_M->derivCacheNeedsReset);
    rtssSetZCCacheNeedsResetPtr(sfcnInfo,
      &Load_Flow_Simulink_M->zCCacheNeedsReset);
    rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo,
      &Load_Flow_Simulink_M->CTOutputIncnstWithState);
    rtssSetSampleHitsPtr(sfcnInfo, &Load_Flow_Simulink_M->Timing.sampleHits);
    rtssSetPerTaskSampleHitsPtr(sfcnInfo,
      &Load_Flow_Simulink_M->Timing.perTaskSampleHits);
    rtssSetSimModePtr(sfcnInfo, &Load_Flow_Simulink_M->simMode);
    rtssSetSolverInfoPtr(sfcnInfo, &Load_Flow_Simulink_M->solverInfoPtr);
  }

  Load_Flow_Simulink_M->Sizes.numSFcns = (2);

  /* register each child */
  {
    (void) memset((void *)&Load_Flow_Simulink_M->
                  NonInlinedSFcns.childSFunctions[0], 0,
                  2*sizeof(SimStruct));
    Load_Flow_Simulink_M->childSfunctions =
      (&Load_Flow_Simulink_M->NonInlinedSFcns.childSFunctionPtrs[0]);
    Load_Flow_Simulink_M->childSfunctions[0] =
      (&Load_Flow_Simulink_M->NonInlinedSFcns.childSFunctions[0]);
    Load_Flow_Simulink_M->childSfunctions[1] =
      (&Load_Flow_Simulink_M->NonInlinedSFcns.childSFunctions[1]);

    /* Level2 S-Function Block: Load_Flow_Simulink/<S3>/OpComm (sfun_rtlab_comm) */
    {
      SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[0];

      /* timing info */
      time_T *sfcnPeriod =
        Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.sfcnPeriod;
      time_T *sfcnOffset =
        Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.sfcnOffset;
      int_T *sfcnTsMap = Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.blkInfo2[0]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &Load_Flow_Simulink_M->NonInlinedSFcns.inputOutputPortInfo2[0]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, Load_Flow_Simulink_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods2
                           [0]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods3
                           [0]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods4
                           [0]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &Load_Flow_Simulink_M->
                         NonInlinedSFcns.statesInfo2[0]);
        ssSetPeriodicStatesInfo(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.periodicStatesInfo[0]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 3);
        ssSetPortInfoForInputs(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        ssSetInputPortUnit(rts, 1, 0);
        ssSetInputPortUnit(rts, 2, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);
        ssSetInputPortIsContinuousQuantity(rts, 1, 0);
        ssSetInputPortIsContinuousQuantity(rts, 2, 0);

        /* port 0 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.UPtrs0;
          sfcnUPtrs[0] = &Load_Flow_Simulink_B.Cte;
          ssSetInputPortSignalPtrs(rts, 0, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }

        /* port 1 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.UPtrs1;
          sfcnUPtrs[0] = &Load_Flow_Simulink_B.Cte;
          ssSetInputPortSignalPtrs(rts, 1, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 1, 1);
          ssSetInputPortWidth(rts, 1, 1);
        }

        /* port 2 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.UPtrs2;
          sfcnUPtrs[0] = &Load_Flow_Simulink_B.Cte;
          ssSetInputPortSignalPtrs(rts, 2, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 2, 1);
          ssSetInputPortWidth(rts, 2, 1);
        }
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 5);
        _ssSetPortInfo2ForOutputUnits(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        ssSetOutputPortUnit(rts, 1, 0);
        ssSetOutputPortUnit(rts, 2, 0);
        ssSetOutputPortUnit(rts, 3, 0);
        ssSetOutputPortUnit(rts, 4, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.outputPortCoSimAttribute
          [0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 1, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 2, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 3, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 4, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *)
            &Load_Flow_Simulink_B.MissedData_b));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidth(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *)
            &Load_Flow_Simulink_B.Offset_d));
        }

        /* port 2 */
        {
          _ssSetOutputPortNumDimensions(rts, 2, 1);
          ssSetOutputPortWidth(rts, 2, 1);
          ssSetOutputPortSignal(rts, 2, ((real_T *)
            &Load_Flow_Simulink_B.SimTime_e));
        }

        /* port 3 */
        {
          _ssSetOutputPortNumDimensions(rts, 3, 1);
          ssSetOutputPortWidth(rts, 3, 1);
          ssSetOutputPortSignal(rts, 3, ((real_T *)
            &Load_Flow_Simulink_B.SampleSec_f));
        }

        /* port 4 */
        {
          _ssSetOutputPortNumDimensions(rts, 4, 1);
          ssSetOutputPortWidth(rts, 4, 1);
          ssSetOutputPortSignal(rts, 4, ((real_T *)
            &Load_Flow_Simulink_B.DynamicSignals_e));
        }
      }

      /* path info */
      ssSetModelName(rts, "OpComm");
      ssSetPath(rts, "Load_Flow_Simulink/sc_user_interface/OpComm/OpComm");
      ssSetRTModel(rts,Load_Flow_Simulink_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.params;
        ssSetSFcnParamsCount(rts, 10);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)Load_Flow_Simulink_P.OpComm_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)Load_Flow_Simulink_P.OpComm_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)Load_Flow_Simulink_P.OpComm_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)Load_Flow_Simulink_P.OpComm_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)Load_Flow_Simulink_P.OpComm_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)Load_Flow_Simulink_P.OpComm_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)Load_Flow_Simulink_P.OpComm_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)Load_Flow_Simulink_P.OpComm_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)Load_Flow_Simulink_P.OpComm_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)Load_Flow_Simulink_P.OpComm_P10_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &Load_Flow_Simulink_DW.OpComm_PWORK_f);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn0.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 1);

        /* PWORK */
        ssSetDWorkWidth(rts, 0, 1);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &Load_Flow_Simulink_DW.OpComm_PWORK_f);
      }

      /* registration */
      sfun_rtlab_comm(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetInputPortWidth(rts, 0, 1);
      ssSetInputPortDataType(rts, 0, SS_DOUBLE);
      ssSetInputPortComplexSignal(rts, 0, 0);
      ssSetInputPortFrameData(rts, 0, 0);
      ssSetInputPortUnit(rts, 0, 0);
      ssSetInputPortIsContinuousQuantity(rts, 0, 0);
      ssSetInputPortWidth(rts, 1, 1);
      ssSetInputPortDataType(rts, 1, SS_DOUBLE);
      ssSetInputPortComplexSignal(rts, 1, 0);
      ssSetInputPortFrameData(rts, 1, 0);
      ssSetInputPortUnit(rts, 1, 0);
      ssSetInputPortIsContinuousQuantity(rts, 1, 0);
      ssSetInputPortWidth(rts, 2, 1);
      ssSetInputPortDataType(rts, 2, SS_DOUBLE);
      ssSetInputPortComplexSignal(rts, 2, 0);
      ssSetInputPortFrameData(rts, 2, 0);
      ssSetInputPortUnit(rts, 2, 0);
      ssSetInputPortIsContinuousQuantity(rts, 2, 0);
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetInputPortConnected(rts, 1, 1);
      _ssSetInputPortConnected(rts, 2, 1);
      _ssSetOutputPortConnected(rts, 0, 0);
      _ssSetOutputPortConnected(rts, 1, 0);
      _ssSetOutputPortConnected(rts, 2, 0);
      _ssSetOutputPortConnected(rts, 3, 0);
      _ssSetOutputPortConnected(rts, 4, 0);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);
      _ssSetOutputPortBeingMerged(rts, 2, 0);
      _ssSetOutputPortBeingMerged(rts, 3, 0);
      _ssSetOutputPortBeingMerged(rts, 4, 0);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
      ssSetInputPortBufferDstPort(rts, 1, -1);
      ssSetInputPortBufferDstPort(rts, 2, -1);
    }

    /* Level2 S-Function Block: Load_Flow_Simulink/<S5>/OpComm (sfun_rtlab_comm) */
    {
      SimStruct *rts = Load_Flow_Simulink_M->childSfunctions[1];

      /* timing info */
      time_T *sfcnPeriod =
        Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.sfcnPeriod;
      time_T *sfcnOffset =
        Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.sfcnOffset;
      int_T *sfcnTsMap = Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.sfcnTsMap;
      (void) memset((void*)sfcnPeriod, 0,
                    sizeof(time_T)*1);
      (void) memset((void*)sfcnOffset, 0,
                    sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.blkInfo2[1]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &Load_Flow_Simulink_M->NonInlinedSFcns.inputOutputPortInfo2[1]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, Load_Flow_Simulink_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods2
                           [1]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods3
                           [1]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &Load_Flow_Simulink_M->NonInlinedSFcns.methods4
                           [1]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &Load_Flow_Simulink_M->
                         NonInlinedSFcns.statesInfo2[1]);
        ssSetPeriodicStatesInfo(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.periodicStatesInfo[1]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);

        /* port 0 */
        {
          real_T const **sfcnUPtrs = (real_T const **)
            &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.UPtrs0;
          sfcnUPtrs[0] = &Load_Flow_Simulink_B.In1;
          ssSetInputPortSignalPtrs(rts, 0, (InputPtrsType)&sfcnUPtrs[0]);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidth(rts, 0, 1);
        }
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 5);
        _ssSetPortInfo2ForOutputUnits(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        ssSetOutputPortUnit(rts, 1, 0);
        ssSetOutputPortUnit(rts, 2, 0);
        ssSetOutputPortUnit(rts, 3, 0);
        ssSetOutputPortUnit(rts, 4, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.outputPortCoSimAttribute
          [0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 1, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 2, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 3, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 4, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidth(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *)
            &Load_Flow_Simulink_B.MissedData));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidth(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *) &Load_Flow_Simulink_B.Offset));
        }

        /* port 2 */
        {
          _ssSetOutputPortNumDimensions(rts, 2, 1);
          ssSetOutputPortWidth(rts, 2, 1);
          ssSetOutputPortSignal(rts, 2, ((real_T *)
            &Load_Flow_Simulink_B.SimTime));
        }

        /* port 3 */
        {
          _ssSetOutputPortNumDimensions(rts, 3, 1);
          ssSetOutputPortWidth(rts, 3, 1);
          ssSetOutputPortSignal(rts, 3, ((real_T *)
            &Load_Flow_Simulink_B.SampleSec));
        }

        /* port 4 */
        {
          _ssSetOutputPortNumDimensions(rts, 4, 1);
          ssSetOutputPortWidth(rts, 4, 1);
          ssSetOutputPortSignal(rts, 4, ((real_T *)
            &Load_Flow_Simulink_B.DynamicSignals));
        }
      }

      /* path info */
      ssSetModelName(rts, "OpComm");
      ssSetPath(rts, "Load_Flow_Simulink/sm_computation/OpComm/OpComm");
      ssSetRTModel(rts,Load_Flow_Simulink_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.params;
        ssSetSFcnParamsCount(rts, 10);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)Load_Flow_Simulink_P.OpComm_P1_Size_p);
        ssSetSFcnParam(rts, 1, (mxArray*)Load_Flow_Simulink_P.OpComm_P2_Size_b);
        ssSetSFcnParam(rts, 2, (mxArray*)Load_Flow_Simulink_P.OpComm_P3_Size_f);
        ssSetSFcnParam(rts, 3, (mxArray*)Load_Flow_Simulink_P.OpComm_P4_Size_a);
        ssSetSFcnParam(rts, 4, (mxArray*)Load_Flow_Simulink_P.OpComm_P5_Size_h);
        ssSetSFcnParam(rts, 5, (mxArray*)Load_Flow_Simulink_P.OpComm_P6_Size_p);
        ssSetSFcnParam(rts, 6, (mxArray*)Load_Flow_Simulink_P.OpComm_P7_Size_i);
        ssSetSFcnParam(rts, 7, (mxArray*)Load_Flow_Simulink_P.OpComm_P8_Size_m);
        ssSetSFcnParam(rts, 8, (mxArray*)Load_Flow_Simulink_P.OpComm_P9_Size_a);
        ssSetSFcnParam(rts, 9, (mxArray*)Load_Flow_Simulink_P.OpComm_P10_Size_n);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &Load_Flow_Simulink_DW.OpComm_PWORK);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &Load_Flow_Simulink_M->NonInlinedSFcns.Sfcn1.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        _ssSetNumDWork(rts, 1);

        /* PWORK */
        ssSetDWorkWidth(rts, 0, 1);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &Load_Flow_Simulink_DW.OpComm_PWORK);
      }

      /* registration */
      sfun_rtlab_comm(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 0.001);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetInputPortWidth(rts, 0, 1);
      ssSetInputPortDataType(rts, 0, SS_DOUBLE);
      ssSetInputPortComplexSignal(rts, 0, 0);
      ssSetInputPortFrameData(rts, 0, 0);
      ssSetInputPortUnit(rts, 0, 0);
      ssSetInputPortIsContinuousQuantity(rts, 0, 0);
      ssSetNumNonsampledZCs(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 0, 0);
      _ssSetOutputPortConnected(rts, 1, 0);
      _ssSetOutputPortConnected(rts, 2, 0);
      _ssSetOutputPortConnected(rts, 3, 0);
      _ssSetOutputPortConnected(rts, 4, 0);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);
      _ssSetOutputPortBeingMerged(rts, 2, 0);
      _ssSetOutputPortBeingMerged(rts, 3, 0);
      _ssSetOutputPortBeingMerged(rts, 4, 0);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }
  }

  /* Initialize Sizes */
  Load_Flow_Simulink_M->Sizes.numContStates = (0);/* Number of continuous states */
  Load_Flow_Simulink_M->Sizes.numY = (0);/* Number of model outputs */
  Load_Flow_Simulink_M->Sizes.numU = (0);/* Number of model inputs */
  Load_Flow_Simulink_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  Load_Flow_Simulink_M->Sizes.numSampTimes = (1);/* Number of sample times */
  Load_Flow_Simulink_M->Sizes.numBlocks = (16);/* Number of blocks */
  Load_Flow_Simulink_M->Sizes.numBlockIO = (16);/* Number of block outputs */
  Load_Flow_Simulink_M->Sizes.numBlockPrms = (65);/* Sum of parameter "widths" */
  return Load_Flow_Simulink_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
