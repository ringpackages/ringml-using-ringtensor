# File: examples/mnist_app.ring
# Description: Interactive MNIST Predictor with ASCII Art
# Author: Azzeddine Remmal

load "ringml.ring"


decimals(8)

see "=== RingML MNIST Digit Predictor ===" + nl

# 1. Load Data (For testing)
# Using the lite version for quick loading in the app
cFile = "data/mnist_test_lite.csv" 
if !fexists(cFile) 
    # Fallback to full test set if lite not found
    cFile = "data/mnist_test.csv"
    if !fexists(cFile) raise("File missing") ok
ok

see "Loading Data (" + cFile + ")..." + nl
aRawData = CSV2List( read(cFile) )

# Check and remove header if exists
if len(aRawData) > 0 
    if lower(aRawData[1][1]) = "label" del(aRawData, 1) ok
ok

nTotal = len(aRawData)
see "Loaded " + nTotal + " test images." + nl

# 2. Build Model Structure 
# IMPORTANT: This architecture MUST match the one used in training!
model = new Sequential

model.add(new Dense(784, 64))   
model.add(new ReLU)
# Note: Dropout layers are not needed during inference (eval mode)
model.add(new Dense(64, 32))  
model.add(new ReLU)
model.add(new Dense(32, 10)) 
model.add(new Softmax)

# 3. Load Weights
cModelFile = "model/mnist_model.rdata"
if !fexists(cModelFile)
    see "Error: Model file not found at " + cModelFile + nl
    see "Please run mnist_train.ring first." + nl
    bye
ok

model.loadWeights(cModelFile)
model.evaluate() # Switch to evaluation mode (disables Dropout)

# 4. Interactive Loop
while true
    see nl + "Enter Image Index (1-" + nTotal + ") or 'exit': " 
    give cInput
    if lower(trim(cInput)) = "exit" exit ok
    
    nIdx = number(cInput)
    if nIdx < 1 or nIdx > nTotal 
        see "Invalid Index!" + nl 
        loop 
    ok
    
    # Get Data Row
    row = aRawData[nIdx]
    realLabel = number(row[1])
    
    # Create Input Tensor
    oInput = new Tensor(1, 784)
    for i = 1 to 784
        # FIX: Use setVal instead of aData for C-Pointer Tensor
        val = number(row[i+1]) / 255.0
        oInput.setVal(1, i, val)
    next
    
    # Predict
    pred = model.forward(oInput)
    
    # Find Max Probability
    nMaxIdx = 0
    nMaxVal = -1
    for i = 1 to 10
        # FIX: Use getVal instead of aData
        val = pred.getVal(1, i)
        if val > nMaxVal
            nMaxVal = val
            nMaxIdx = i
        ok
    next
    
    predictedLabel = nMaxIdx - 1 # Convert 1-based index to 0-9 digit
    
    # --- Visualization ---
    see nl + "Image " + nIdx + ":" + nl
    printAsciiArt(oInput)
    
    see "--------------------------" + nl
    see "Real Label: " + realLabel + nl
    see "AI Predict: " + predictedLabel 
    see " (Confidence: " + floor(nMaxVal*100) + "%)" + nl
    
    if realLabel = predictedLabel
        see "RESULT: CORRECT ✅" + nl
    else
        see "RESULT: WRONG ❌" + nl
    ok
end

func printAsciiArt oTensor
    # Draw 28x28 image using ASCII chars
    # Input is (1, 784) normalized 0-1
    
    cMap = " .:-=+*#%@"
    nLevels = len(cMap)
    
    idx = 1
    for y = 1 to 28
        line = ""
        for x = 1 to 28
            # FIX: Use getVal instead of aData
            val = oTensor.getVal(1, idx)
            
            # Map 0.0-1.0 to 1-10 char index
            charIdx = floor(val * (nLevels-1)) + 1
            if charIdx < 1 charIdx = 1 ok
            
            line += cMap[charIdx] + " " # Extra space for aspect ratio
            idx++
        next
        see "    " + line + nl
    next