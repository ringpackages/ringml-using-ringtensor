# File: examples/loader_demo.ring
# Description: DataLoader Demo
# Author: Azzeddine Remmal

# File: examples/loader_demo.ring

load "../src/ringml.ring" # تأكد من المسار الصحيح
load "stdlib.ring"

decimals(4) 

see "=== DataLoader Demo (Pointer Based) ===" + nl

# 1. Create Dummy Data (10 Samples)
inputs = new Tensor(10, 2)
targets = new Tensor(10, 1)

# طباعة الخصائص للتأكد (سترى pData بدلاً من aData)
see "Tensor Attributes: " 
see attributes(inputs) 
see nl

# Fill with dummy data using setVal
# Old: inputs.aData[i] = [i, i*2]  <-- خطأ
# New: setVal(row, col, val)
for i = 1 to 10
    # Input: [i, i*2]
    inputs.setVal(i, 1, i)
    inputs.setVal(i, 2, i*2)
    
    # Target: [1]
    targets.setVal(i, 1, 1.0)
next

# 2. Wrap in Dataset
dataset = new TensorDataset(inputs, targets)

# 3. Create DataLoader (Batch Size = 4)
# This should create 3 batches: (4 samples, 4 samples, 2 samples)
loader = new DataLoader(dataset, 4)

see "Total Samples: " + dataset.len() + nl
see "Batch Size:    " + loader.nBatchSize + nl
see "Num Batches:   " + loader.nBatches + nl + nl

# 4. Iterate Batches
for b = 1 to loader.nBatches
    see "--- Batch " + b + " ---" + nl
    batchData = loader.getBatch(b)
    
    # batchData is a list [InputTensor, TargetTensor]
    batchX = batchData[1]
    batchY = batchData[2]
    
    see "Input Shape: " 
    batchX.print()
    
    see "Target Shape: "
    batchY.print()
next