# RingML: Deep Learning Library for Ring

## 1. Vision
RingML is a modular, high-performance Deep Learning framework built from scratch in the Ring programming language. It leverages the FastPro C-extension to perform accelerated matrix operations, enabling the training of Neural Networks for tasks like regression and multi-class classification. The goal is to provide a PyTorch-like object-oriented API for Ring developers.

## 2. Tech Stack
- **Core Language**: Ring Programming Language (v1.24+)
- **Acceleration**: FastPro Extension (C-based DLL/SO)
- **Architecture**: Modular OOP (Tensor, Layers, Model, Optim, Data)
- **Data Format**: CSV for datasets, .rdata for model persistence

## 3. Constraints & Guidelines
- **Precision**: Must ensure high-precision floating-point arithmetic (Double), handling FastPro's casting limitations.
- **Design Pattern**: Follows Jacob's Law by mimicking familiar APIs (PyTorch/Keras) for ease of use.
- **Performance**: Use batch processing (DataLoader) to manage memory and speed.

## 4. Functional Modules
The project is divided into the following functional modules:

### Module 1: Core Engine
- **Focus**: Mathematical foundation.
- **Components**: `Tensor` class, FastPro wrappers, Matrix operations (MatMul, Transpose).

### Module 2: Neural Building Blocks
- **Focus**: Network layers and activation functions.
- **Components**: `Layer` (Base), `Dense` (Fully Connected), `ReLU`, `Sigmoid`, `Softmax`.

### Module 3: Model Management & Optimization
- **Focus**: Training loop and model structure.
- **Components**: `Sequential` container, `SGD` Optimizer, `MSELoss`, `CrossEntropyLoss`.

### Module 4: Data Pipeline
- **Focus**: Efficient data handling.
- **Components**: `Dataset` (Base), `DataLoader` (Mini-batching).

### Module 5: Real-World Verification
- **Focus**: Testing and Demos.
- **Components**: XOR Example, Chess End-Game Classification.

## 5. To-Do List & Progress
**Status**: ✅ Stable / 🚧 In Progress

- [x] **T01.01**: Implement `Tensor` class with FastPro integration.
- [x] **T01.02**: Implement matrix operations (Add, Sub, ScalarMul, MatMul, Transpose).
- [x] **T02.01**: Create abstract `Layer` class.
- [x] **T02.02**: Implement `Dense` layer with weight initialization.
- [x] **T02.03**: Implement Activations (`Sigmoid`, `ReLU`, `Softmax`).
- [x] **T03.01**: Build `Sequential` model container (Forward/Backward).
- [x] **T03.02**: Implement `SGD` Optimizer.
- [x] **T03.03**: Implement Loss functions (`MSE`, `CrossEntropy`).
- [x] **T03.04**: Add Model Persistence (`saveWeights`, `loadWeights`).
- [x] **T04.01**: Implement `DataLoader` for mini-batch processing.
- [x] **T05.01**: Create XOR training example ("Hello World").
- [x] **T05.02**: Create Chess End-Game classification app.
- [x] **T05.03**: Write Unit Tests for gradients and math.

---

## 📚 Project Documentation

### 📁 Project Structure
```text
RingML/
├── src/                        # Core Library Source Code
│   ├── core/                   # Mathematical Engine (Tensor)
│   ├── layers/                 # Neural Network Layers (Dense, ReLU, Softmax)
│   ├── loss/                   # Loss Functions (MSE, CrossEntropy)
│   ├── model/                  # Model Container (Sequential)
│   ├── optim/                  # Optimizers (SGD)
│   ├── data/                   # Data Handling (Dataset, DataLoader)
│   └── utils/                  # Utilities (Serializer)
│
├── examples/                   # Usage Examples
│   ├── xor_train.ring          # Binary Classification (Hello World of DL)
│   ├── classify_demo.ring      # Multi-Class Classification
│   ├── save_load_demo.ring     # Model Persistence Demo
│   │
│   └── Chess_End_Game/         # Real-world Application
│       ├── chess_train_fast.ring  # Optimized Training Script
│       ├── chess_app.ring         # Inference Application
│       └── chess_dataset.ring     # Custom Data Handling
│
└── tests/                      # Unit Tests for Math & Gradients
```

### 🛠️ Core Architecture (src/)
The library follows a PyTorch-like object-oriented design.

#### 1. Tensor Engine (`src/core/tensor.ring`)
The heart of the library. It wraps FastPro C-functions to handle matrix operations efficiently.
- **Key Features**: `matmul`, `transpose`, `add`, `sub`, `scalar_mul`.
- **Fixes**: Includes workarounds for FastPro's float casting and transpose logic issues.

#### 2. Layers (`src/layers/`)
- **Layer**: Abstract base class enforcing `forward()` and `backward()`.
- **Dense**: Fully Connected Layer. Manages Weights ($W$) and Biases ($B$).
- **Activations**:
  - `Sigmoid`: For binary outputs or hidden layers.
  - `ReLU`: Rectified Linear Unit (Standard for hidden layers).
  - `Softmax`: Converts outputs to probabilities for multi-class classification.

#### 3. Model Management (`src/model/`)
- **Sequential**: A container that stacks layers linearly.
  - `forward(input)`: Passes data through all layers.
  - `backward(gradient)`: Propagates errors backward.
  - `saveWeights(file)`: Serializes model parameters.
  - `loadWeights(file)`: Restores model state.

#### 4. Optimization & Loss (`src/optim/`, `src/loss/`)
- **SGD**: Stochastic Gradient Descent optimizer.
- **MSELoss**: Mean Squared Error (Regression).
- **CrossEntropyLoss**: Classification loss combining log-likelihood with Softmax.

#### 5. Data Loading (`src/data/`)
- **DataLoader**: Handles Mini-Batch Processing, slicing data into small batches (e.g., 64 or 256 samples) to improve performance and memory usage.

### 🚀 Usage Examples

#### 1. The "Hello World" (XOR Problem)
Located in `examples/xor_train.ring`.
- **Input**: 2 features.
- **Output**: 1 prediction (0 or 1).
- **Result**: Loss decreases to ~0.0002.

#### 2. Real-World Case: Chess End-Game
Predicts the result of a Chess End-Game (King + Rook vs. King).
- **Dataset**: `chess.csv` (28,056 games).
- **Architecture**: `Input(6) -> Dense(32) -> Sigmoid -> Dense(16) -> Sigmoid -> Dense(18) -> Softmax`.
- **Inference**: `chess_app.ring` allows users to input board coordinates and get predictions.

### 📦 Installation
1. Copy the `src` folder to your project.
2. Ensure `fastpro.dll` (or `.so`) is available.
3. Import the library:
   ```ring
   load "src/ringml.ring"
   ```