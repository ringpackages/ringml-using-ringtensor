# File: examples/mnist_dataset.ring
# Description: Dataset loader for MNIST CSV format
# Author: Azzeddine Remmal


class MnistDataset from Dataset
    aRawData
    nRows
    nClasses = 10 # Digits 0-9

    func init aData
        aRawData = aData
        nRows    = len(aRawData)

    func length
        return nRows

    func getData nIdx
        row = aRawData[nIdx]
        
        # --- 1. Process Label (First Column) ---
        nLabel = number(row[1]) # 0 to 9
        
        # Create Target Tensor (1, 10)
        # It is initialized with zeros automatically by C extension
        oTargetTensor = new Tensor(1, nClasses)
        
        # Set the One-Hot index to 1.0 using setVal
        # Ring lists are 1-based, so digit 0 is at index 1
        oTargetTensor.setVal(1, nLabel + 1, 1.0)

        # --- 2. Process Image Pixels (Rest of Columns) ---
        nPixels = 784 # 28x28
        
        oInTensor = new Tensor(1, nPixels)
        
        # CSV Row has 785 columns (1 label + 784 pixels)
        # Pixel 1 starts at index 2 in the CSV row
        for i = 1 to nPixels
            # Normalize 0-255 to 0.0-1.0
            val = number(row[i+1]) / 255.0
            
            # Set value directly in Tensor using setVal
            oInTensor.setVal(1, i, val)
        next

        return [oInTensor, oTargetTensor]