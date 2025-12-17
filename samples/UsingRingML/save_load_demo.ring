# File: examples/save_load_demo.ring
# Description: Save/Load Model Demo
# Author: Azzeddine Remmal

load "ringml.ring"


decimals(4)

see "=== RingML Save/Load Model Demo ===" + nl

# 1. Prepare Data (XOR) - (Updated for C-Pointers)
# We use a helper function 'listToTensor' to convert lists to Tensor
aIn  = [[0,0], [0,1], [1,0], [1,1]]
aOut = [[0],   [1],   [1],   [0]]

inputs  = listToTensor(aIn)
targets = listToTensor(aOut)

# 2. Train Model A
see "--> Training Model A..." + nl
modelA = new Sequential
modelA.add(new Dense(2, 4))
modelA.add(new Sigmoid)
modelA.add(new Dense(4, 1))
modelA.add(new Sigmoid)

optimizer = new SGD(0.5)
criterion = new MSELoss

for epoch = 1 to 2000
    preds = modelA.forward(inputs)
    grad  = criterion.backward(preds, targets)
    modelA.backward(grad)
    for l in modelA.getLayers() optimizer.update(l) next
    
    if epoch % 200 = 0 see "." ok
next
see nl

see "Model A Predictions (Trained):" + nl
predA = modelA.forward(inputs)
predA.print()

# 3. Save Model A
cFile = "xor_weights.rdata"
modelA.saveWeights(cFile)

# 4. Create Model B (Untrained)
see nl + "--> Creating Model B (Same Architecture, Untrained)..." + nl
modelB = new Sequential
modelB.add(new Dense(2, 4))
modelB.add(new Sigmoid)
modelB.add(new Dense(4, 1))
modelB.add(new Sigmoid)

see "Model B Predictions (Before Loading):" + nl
predB = modelB.forward(inputs)
predB.print()

# 5. Load Weights into Model B
modelB.loadWeights(cFile)

see "Model B Predictions (After Loading):" + nl
predB = modelB.forward(inputs)
predB.print()

# 6. Verification
see "--> Verification: "

# FIX: Use getVal() instead of aData[][]
valA = predA.getVal(1, 1)
valB = predB.getVal(1, 1)

diff = fabs(valA - valB)

if diff < 0.0001
    see "SUCCESS (Models Match)" + nl
else
    see "FAILURE (Mismatch)" + nl
ok

# --- Helper Function ---
func listToTensor aList
    nRows = len(aList)
    nCols = len(aList[1])
    oTen = new Tensor(nRows, nCols)
    for r = 1 to nRows
        for c = 1 to nCols
            oTen.setVal(r, c, aList[r][c])
        next
    next
    return oTen