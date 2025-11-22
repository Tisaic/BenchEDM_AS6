# TC_NGRC Library

**Time-Series Nonlinear General Regression Continuous**

A production-ready library for real-time continuous learning and prediction on industrial PLCs.

[![Platform](https://img.shields.io/badge/Platform-B%26R%20Automation%20Studio-blue)]()
[![Language](https://img.shields.io/badge/Language-IEC%2061131--3%20ST-orange)]()
[![Version](https://img.shields.io/badge/Version-1.0-green)]()

---

## 📋 Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Library Components](#library-components)
- [Memory Optimization](#memory-optimization)
- [Usage Examples](#usage-examples)
- [API Reference](#api-reference)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Documentation](#documentation)

---

## 🎯 Overview

**TC_NGRC** implements online machine learning using Recursive Least Squares (RLS) with polynomial feature expansion for multivariate time-series prediction on industrial PLCs.

### What It Does

- **Continuous Learning**: Models adapt in real-time as new data arrives
- **Multi-Variable Prediction**: Handle up to 10 variables simultaneously  
- **Multi-Step Forecasting**: Predict multiple steps ahead (1-10 steps)
- **Memory Optimized**: Application-specific sizing reduces memory usage by **50-200×**
- **Production Ready**: Comprehensive error handling, state management, and diagnostics

### Typical Applications

| Application | Use Case |
|-------------|----------|
| **Robotic Control** | Learn inverse kinematics, predict joint trajectories |
| **Process Control** | Adapt to changing process dynamics, predict outputs |
| **Predictive Maintenance** | Forecast sensor values, detect anomalies |
| **Quality Control** | Predict product quality from process variables |
| **Energy Management** | Forecast consumption, optimize usage |

---

## ✨ Key Features

### 🚀 Performance
- Executes in single PLC cycle (deterministic timing)
- Optimized for real-time operation
- Minimal CPU overhead with workspace reuse

### 💾 Memory Efficiency
- Application-specific array sizing (50-200× reduction vs generic arrays)
- Shared workspace strategy eliminates redundant allocations
- Memory calculator tool provides exact requirements

### 🔧 Flexibility
- Support for 1-10 variables
- Configurable lag order (1-10 timesteps)
- Polynomial expansion: linear, quadratic, or cubic
- Runtime-adjustable learning rate (Lambda)
- Multi-step prediction (1-10 steps ahead)

### 🛡️ Robustness
- Comprehensive pointer validation
- Dimension mismatch detection
- Singular matrix handling
- Per-variable error tracking
- Graceful degradation on failures

### 📊 Diagnostics
- Real-time RMSE metrics per variable
- Sample count tracking
- Training failure counters
- State machine status reporting

---

## 🚀 Quick Start

### Step 1: Calculate Memory Requirements
```pascal
VAR
    CalcOutput : TC_NGRC_CalcMem_Output_typ;
END_VAR

TC_NGRC_CalcMem(
    NumVariables := 6,
    LagOrder := 2,
    PolyOrder := 1,
    UseBias := TRUE,
    Stride := 1,
    EnableWorkspaceReuse := TRUE,
    pOutput := ADR(CalcOutput)
);

(* Note: CalcOutput.MAX_THETA_IDX = 12 *)
(* Note: CalcOutput.MAX_P_IDX = 168 *)
(* Note: CalcOutput.TotalMemory_WithReuse_Bytes = 9,040 *)
```

### Step 2: Define Application Types
```pascal
TYPE
    MyApp_Theta_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..12] OF LREAL;  (* From MAX_THETA_IDX *)
    END_STRUCT;
    
    MyApp_P_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..168] OF LREAL;  (* From MAX_P_IDX *)
    END_STRUCT;
    
    (* ... other types ... *)
END_TYPE
```

### Step 3: Use the Function Block
```pascal
PROGRAM MyApplication
VAR
    (* Optimally-sized arrays *)
    Theta : ARRAY[0..5] OF MyApp_Theta_typ;
    P : ARRAY[0..5] OF MyApp_P_typ;
    History : ARRAY[0..5] OF MyApp_History_typ;
    Features : MyApp_Features_typ;
    SharedWorkspace : MyApp_SharedWorkspace_typ;
    
    (* Function block *)
    Model : TC_NGRC_Continuous;
    
    (* Data *)
    SensorValues : ARRAY[0..5] OF LREAL;
    Predictions : ARRAY[0..5] OF LREAL;
    
    FirstScan : BOOL := TRUE;
END_VAR

(* Initialize *)
IF FirstScan THEN
    Model.In.Par.NumVariables := 6;
    Model.In.Par.LagOrder := 2;
    Model.In.Par.PolyOrder := 1;
    Model.In.Par.UseBias := TRUE;
    Model.In.Par.PredictionSteps := 3;
    Model.In.Par.Lambda := 0.999;
    Model.In.Par.InitVariance := 1000.0;
    
    (* Assign memory pointers *)
    Model.In.Par.pTheta := ADR(Theta[0]);
    Model.In.Par.pP := ADR(P[0]);
    Model.In.Par.pHistory := ADR(History[0]);
    Model.In.Par.pFeatures := ADR(Features);
    Model.In.Par.pSharedWorkspace := ADR(SharedWorkspace);
    
    (* Initialize dimensions *)
    FOR i := 0 TO 5 DO
        Theta[i].Row := 13; Theta[i].Col := 1;
        P[i].Row := 13; P[i].Col := 13;
        History[i].Row := 2; History[i].Col := 1;
    END_FOR;
    
    Model.In.Cmd.Init := TRUE;
    FirstScan := FALSE;
END_IF;

(* Every cycle *)
Model.In.Signal.NewSample := SensorValues;
Model.In.Cmd.Enable := TRUE;
Model();

(* Use predictions *)
IF Model.Out.Status.Ready THEN
    FOR i := 0 TO 5 DO
        Predictions[i] := Model.Out.Signal.Prediction[i, 0];  (* 1-step ahead *)
    END_FOR;
END_IF;

END_PROGRAM
```

---

## 🏗️ Architecture

### Two-Layer Design
```
┌─────────────────────────────────────────────────────────────┐
│  HIGH-LEVEL LAYER                                            │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  TC_NGRC_Continuous (Function Block)                 │   │
│  │  - State machine management                           │   │
│  │  - Automatic history updates                          │   │
│  │  - Multi-step prediction                              │   │
│  │  - Diagnostics and error handling                     │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↓ calls
┌─────────────────────────────────────────────────────────────┐
│  LOW-LEVEL LAYER (Core Functions)                           │
│  ┌──────────────┬──────────────┬──────────────┐            │
│  │ RLS Update   │ Prediction   │ Feature      │            │
│  │ RLS Init     │ RMSE Calc    │ Engineering  │            │
│  └──────────────┴──────────────┴──────────────┘            │
└─────────────────────────────────────────────────────────────┘
```

### Memory Layout

All array types use **metadata-first layout** for size-independent operation:
```
TC_NGRC_Array_typ Structure:
┌─────────────────────────────────────────────┐
│ Offset 0:  Row (DINT)      - 4 bytes        │  Fixed position
├─────────────────────────────────────────────┤
│ Offset 4:  Col (DINT)      - 4 bytes        │  Fixed position
├─────────────────────────────────────────────┤
│ Offset 8:  M[0] (LREAL)    - 8 bytes        │  Data starts here
│            M[1] (LREAL)    - 8 bytes        │
│            ...                               │
│            M[n] (LREAL)    - 8 bytes        │
└─────────────────────────────────────────────┘
```

**Benefits:**
- Functions read Row/Col at fixed offsets (0 and 4)
- Data always starts at offset 8
- Works with ANY array size
- No dependency on library constants

---

## 📦 Library Components

### File Structure
```
TC_NGRC/
├── Types.typ                          # Type definitions
├── Constants.var                      # Error code constants
├── TC_NGRC.fun                        # Function declarations
│
├── Core Functions/
│   ├── TC_NGRC_RLS.st                # Recursive Least Squares update
│   ├── TC_NGRC_RLS_Init.st           # Initialize RLS
│   ├── TC_NGRC_Predict.st            # Make predictions
│   ├── TC_NGRC_RMSE.st               # Calculate RMSE
│   ├── TC_NGRC_BuildLagsStride.st    # Build lag features
│   ├── TC_NGRC_PolyExpand.st         # Polynomial expansion
│   ├── TC_NGRC_AddBias.st            # Add bias term
│   └── TC_NGRC_RollingUpdate.st      # Update history buffer
│
├── Utilities/
│   └── TC_NGRC_CalcMem.st            # Memory calculator
│
└── High-Level/
    └── TC_NGRC_Continuous.st         # Main function block
```

### Core Functions

| Function | Purpose | Returns |
|----------|---------|---------|
| `TC_NGRC_RLS` | Update model weights | BOOL |
| `TC_NGRC_RLS_Init` | Initialize RLS | BOOL |
| `TC_NGRC_Predict` | Generate predictions | BOOL |
| `TC_NGRC_BuildLagsStride` | Build lag features | BOOL |
| `TC_NGRC_PolyExpand` | Polynomial features | BOOL |
| `TC_NGRC_AddBias` | Add intercept term | BOOL |
| `TC_NGRC_RollingUpdate` | Update history | BOOL |
| `TC_NGRC_RMSE` | Calculate error metric | LREAL |
| `TC_NGRC_CalcMem` | Memory calculator | BOOL |

---

## 💾 Memory Optimization

### The Problem

Generic arrays waste memory:
```
Configuration: 6 variables, Lag=2, Poly=1, Bias=TRUE
Needed: 13 features → P matrix = 13×13 = 169 elements

With generic 6000-element arrays:
- Memory allocated: 6 models × 48KB = 288 KB
- Memory actually used: 6 models × 1.4KB = 8.4 KB
- Waste: 97% unused! ❌
```

### The Solution

**Application-specific sizing reduces memory by 32×:**
```pascal
(* Step 1: Calculate requirements *)
TC_NGRC_CalcMem(...) → MAX_THETA_IDX = 12, MAX_P_IDX = 168

(* Step 2: Define exact-sized types *)
TYPE
    MyApp_Theta_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..12] OF LREAL;  (* 13 elements, not 6000! *)
    END_STRUCT;
END_TYPE

(* Result: 9 KB instead of 288 KB ✅ *)
```

### Memory Savings Examples

| Configuration | Generic | Optimized | Savings |
|---------------|---------|-----------|---------|
| 1 var, Lag=2, Poly=1 | 288 KB | 1.6 KB | **180×** |
| 6 var, Lag=2, Poly=1 | 288 KB | 9.0 KB | **32×** |
| 10 var, Lag=2, Poly=1 | 480 KB | 25 KB | **19×** |

### Workspace Reuse Strategy
```
Without Reuse (separate buffers):
├── LagWork: 96 bytes
├── PolyWork: 104 bytes
└── TempWork[6]: 624 bytes
    Total: 824 bytes

With Reuse (shared buffer):
└── SharedWorkspace: 104 bytes  ← Replaces all three!
    Total: 104 bytes (8× reduction) ✅
```

---

## 📚 Usage Examples

### Example 1: Robot Joint Prediction

Predict 6 robot joint angles 3 steps ahead with continuous learning:
```pascal
PROGRAM RobotPrediction
VAR
    Model : TC_NGRC_Continuous;
    JointAngles : ARRAY[0..5] OF LREAL;
    (* ... memory arrays ... *)
END_VAR

(* Initialize once *)
IF FirstScan THEN
    Model.In.Par.NumVariables := 6;
    Model.In.Par.LagOrder := 2;
    Model.In.Par.PolyOrder := 1;
    Model.In.Par.UseBias := TRUE;
    Model.In.Par.PredictionSteps := 3;
    Model.In.Par.Lambda := 0.999;
    Model.In.Cmd.Init := TRUE;
END_IF;

(* Every cycle *)
JointAngles := ReadRobotJoints();
Model.In.Signal.NewSample := JointAngles;
Model.In.Cmd.Enable := TRUE;
Model();

(* Use predictions for feedforward *)
IF Model.Out.Status.Ready THEN
    Robot.Feedforward.Joint1 := Model.Out.Signal.Prediction[0, 1];  (* 2-step ahead *)
    (* ... *)
END_IF;

END_PROGRAM
```

### Example 2: Process Control with Adaptive Lambda

Automatically adjust learning rate based on prediction accuracy:
```pascal
VAR
    Model : TC_NGRC_Continuous;
    TargetRMSE : LREAL := 0.05;
END_VAR

Model();

IF Model.Out.Status.Ready THEN
    (* Adjust Lambda based on error *)
    IF Model.Out.Signal.OverallRMSE > TargetRMSE * 2.0 THEN
        Model.In.Par.Lambda := 0.95;   (* High error - fast learning *)
    ELSIF Model.Out.Signal.OverallRMSE < TargetRMSE THEN
        Model.In.Par.Lambda := 0.9995; (* Low error - stabilize *)
    ELSE
        Model.In.Par.Lambda := 0.999;  (* Balanced *)
    END_IF;
END_IF;
```

### Example 3: Warm Start with Historical Data

Pre-fill history buffers for faster convergence:
```pascal
VAR
    Model : TC_NGRC_Continuous;
    RecordedHistory : ARRAY[0..5, 0..99] OF LREAL;
END_VAR

(* Load historical data *)
LoadHistoricalData(ADR(RecordedHistory));

(* Point to last samples *)
Model.In.Par.pHistoryData := ADR(RecordedHistory[0, 98]);

(* Initialize and load *)
Model.In.Cmd.Init := TRUE;
Model();

(* After initialization *)
IF Model.Out.Status.Initialized THEN
    Model.In.Cmd.LoadHistory := TRUE;  (* Load pre-recorded data *)
END_IF;
```

---

## 📖 API Reference

### TC_NGRC_Continuous Function Block

#### Input Structure
```pascal
In.Cmd.Init : BOOL;              (* Initialize/reinitialize - rising edge *)
In.Cmd.Enable : BOOL;            (* Enable continuous operation *)
In.Cmd.Reset : BOOL;             (* Reset to idle - rising edge *)
In.Cmd.PredictOnly : BOOL;       (* Disable training, only predict *)
In.Cmd.LoadHistory : BOOL;       (* Load pre-recorded history - rising edge *)

In.Par.NumVariables : DINT;      (* Number of variables (1-10) *)
In.Par.LagOrder : DINT;          (* Past timesteps (1-10) *)
In.Par.PolyOrder : DINT;         (* 1=linear, 2=quadratic, 3=cubic *)
In.Par.UseBias : BOOL;           (* Add intercept term *)
In.Par.PredictionSteps : DINT;   (* Steps ahead to predict (1-10) *)
In.Par.Lambda : LREAL;           (* Forgetting factor (0,1] *)
In.Par.InitVariance : LREAL;     (* Initial covariance *)

In.Par.pTheta : UDINT;           (* Pointer to model parameters *)
In.Par.pP : UDINT;               (* Pointer to covariance matrices *)
In.Par.pHistory : UDINT;         (* Pointer to history buffers *)
In.Par.pFeatures : UDINT;        (* Pointer to feature vector *)
In.Par.pSharedWorkspace : UDINT; (* Pointer to shared workspace *)
In.Par.pHistoryData : UDINT;     (* Pointer to pre-recorded data *)

In.Signal.NewSample : ARRAY[0..9] OF LREAL;  (* New data each cycle *)
In.Ref.TargetValues : ARRAY[0..9] OF LREAL;  (* For RMSE calculation *)
```

#### Output Structure
```pascal
Out.Status.Ready : BOOL;                          (* Ready for operation *)
Out.Status.Busy : BOOL;                           (* Initializing *)
Out.Status.Error : BOOL;                          (* Error occurred *)
Out.Status.Initialized : BOOL;                    (* Successfully initialized *)
Out.Status.Training : BOOL;                       (* Currently updating models *)
Out.Status.Predicting : BOOL;                     (* Generating predictions *)
Out.Status.SampleCount : UDINT;                   (* Samples processed *)
Out.Status.UpdatesFailed : ARRAY[0..9] OF UDINT;  (* RLS failures per variable *)

Out.Signal.Prediction : ARRAY[0..9, 0..9] OF LREAL;  (* [var_idx, step_ahead] *)
Out.Signal.RMSE : ARRAY[0..9] OF LREAL;              (* Per-variable RMSE *)
Out.Signal.OverallRMSE : LREAL;                      (* Average RMSE *)

Out.ErrorInfo.ErrorCode : DINT;           (* Error code (0=success) *)
Out.ErrorInfo.FunctionName : STRING[40];  (* Which function failed *)
Out.ErrorInfo.ErrorMsg : STRING[80];      (* Human-readable description *)
```

### State Machine
```
IDLE (0) → INITIALIZING (1) → RUNNING (2) ⇄ ERROR (3)
```

| State | Description | Entry | Exit |
|-------|-------------|-------|------|
| **IDLE** | Not operational | Power-on, Reset | Init cmd |
| **INITIALIZING** | Validating config, initializing models | Init cmd | Success/Fail |
| **RUNNING** | Continuous learning and prediction | Enable=TRUE | Enable=FALSE, Error |
| **ERROR** | Fault state | Validation/function failure | Reset/Init |

### Error Codes
```pascal
0  = TC_NGRC_ERR_SUCCESS            (* No error *)
1  = TC_NGRC_ERR_NULL_POINTER       (* Null pointer passed *)
2  = TC_NGRC_ERR_INVALID_DIMENSIONS (* Invalid Row/Col values *)
3  = TC_NGRC_ERR_DIMENSION_MISMATCH (* Incompatible dimensions *)
4  = TC_NGRC_ERR_SINGULAR_MATRIX    (* Matrix inversion failed *)
5  = TC_NGRC_ERR_INVALID_LAMBDA     (* Lambda not in (0,1] *)
6  = TC_NGRC_ERR_INVALID_ORDER      (* Polynomial order not 1-3 *)
7  = TC_NGRC_ERR_INVALID_VARIANCE   (* InitVariance ≤ 0 *)
8  = TC_NGRC_ERR_BUFFER_TOO_SMALL   (* Array capacity exceeded *)
```

---

## ⚡ Best Practices

### ✅ DO

- **Always run `TC_NGRC_CalcMem`** before deploying to get exact memory requirements
- **Set all `.Row` and `.Col` dimensions** before first use
- **Start with Lambda = 0.999** for most applications
- **Use bias term** (`UseBias=TRUE`) in almost all cases
- **Monitor RMSE metrics** continuously and set alert thresholds
- **Implement recovery strategies** for singular matrix errors
- **Call function block at consistent cycle rate** for temporal consistency
- **Pass `pError` parameter** in production code for diagnostics

### ❌ DON'T

- **Don't guess at array sizes** - use calculator
- **Don't use Lambda < 0.9** (usually too aggressive)
- **Don't skip cycles** (breaks temporal consistency)
- **Don't ignore function return values** - always check
- **Don't jump straight to cubic polynomials** - start simple
- **Don't deploy untested configurations** on production systems
- **Don't use `InitVariance = 0`** (will fail)
- **Don't rely solely on predictions** without fallback control

### Lambda Selection Guide

| Lambda | Adaptation Speed | Use Case |
|--------|-----------------|----------|
| **0.999** | Slow/Stable | Steady-state systems, production default |
| **0.99** | Moderate | Balanced adaptation and stability |
| **0.95** | Fast | Rapidly changing systems, commissioning |

---

## 🔧 Troubleshooting

### Models Not Learning

**Symptoms:** Predictions don't improve, RMSE constant

**Fixes:**
- ✅ Check `Model.Out.Status.Training = TRUE` (not in PredictOnly mode)
- ✅ Reduce Lambda from 0.9999 → 0.999
- ✅ Increase InitVariance to 1000.0 and reinitialize
- ✅ Wait for more training samples (100+)

### Singular Matrix Errors

**Symptoms:** `UpdatesFailed` counters incrementing, instability

**Fixes:**
- ✅ Increase Lambda from 0.95 → 0.999
- ✅ Reduce PolyOrder to avoid collinear features
- ✅ Normalize input data to range [-1, 1]
- ✅ Reinitialize: `Model.In.Cmd.Init := TRUE`

### High RMSE

**Symptoms:** Poor prediction accuracy

**Fixes:**
- ✅ Increase model complexity (LagOrder or PolyOrder)
- ✅ Reduce model complexity if overfitting
- ✅ Pre-filter noisy input signals
- ✅ Verify `In.Ref.TargetValues` set correctly

### Memory/Dimension Errors

**Symptoms:** Immediate function failures

**Fixes:**
- ✅ Ensure all `.Row` and `.Col` initialized
- ✅ Re-run `TC_NGRC_CalcMem` and resize arrays
- ✅ Verify Theta.Row = P.Row = P.Col = Features.Row

### Function Block Stuck in Error

**Symptoms:** `Out.Status.Error = TRUE`, no predictions

**Fixes:**
```pascal
(* Option 1: Reset *)
Model.In.Cmd.Reset := TRUE;

(* Option 2: Reinitialize *)
Model.In.Cmd.Init := TRUE;
```

---

## 📋 Mathematical Background

### Recursive Least Squares (RLS)

**Problem:** Estimate parameters θ in linear model: y = X'θ + ε

**RLS Update Equations:**
```
K(t) = P(t-1)·X(t) / (λ + X'(t)·P(t-1)·X(t))     [Kalman gain]
e(t) = y(t) - X'(t)·θ(t-1)                       [Prediction error]
θ(t) = θ(t-1) + K(t)·e(t)                        [Parameter update]
P(t) = (P(t-1) - K(t)·X'(t)·P(t-1)) / λ          [Covariance update]
```

**Where:**
- **θ**: Parameter vector (what we're learning)
- **P**: Error covariance matrix (uncertainty estimate)
- **X**: Feature vector (inputs)
- **y**: Observed output
- **λ**: Forgetting factor (0 < λ ≤ 1)
- **K**: Kalman gain (optimal step size)

### Polynomial Feature Expansion

**Purpose:** Transform linear features into nonlinear space

**Order 2 (Quadratic):**
```
[x₁, x₂] → [x₁, x₂, x₁², x₁x₂, x₂²]
```

**Order 3 (Cubic):**
```
[x₁, x₂] → [x₁, x₂, x₁², x₁x₂, x₂², x₁³, x₁²x₂, x₁x₂², x₂³]
```