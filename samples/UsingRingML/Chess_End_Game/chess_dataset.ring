# File: examples/chess_dataset.ring
# Description: Custom Dataset for Chess Data (Lazy Loading)
# Author: Azzeddine Remmal


class ChessDataset from Dataset
    aRawData
    nRows
    nClasses = 18
    
    func init aData
        aRawData = aData
        nRows    = len(aRawData)

    func length
        return nRows

    func getData nIdx
        # This function processes ONLY ONE row on demand
        row = aRawData[nIdx]

        # 1. Process Input
        wk_f = getFileIndex(row[1])
        wk_r = number(row[2])
        wr_f = getFileIndex(row[3])
        wr_r = number(row[4])
        bk_f = getFileIndex(row[5])
        bk_r = number(row[6])
        
        normList = normalizeBoard([wk_f, wk_r, wr_f, wr_r, bk_f, bk_r])
        
        # Create small Tensor for Input (1, 6)
        oInTensor = new Tensor(1, 6)
        
        # FIX: Use setVal instead of direct list access
        for i = 1 to 6
            oInTensor.setVal(1, i, normList[i])
        next

        # 2. Process Target
        cLabel = row[7]
        nLabelIdx = getLabelIndex(cLabel)
        
        # Create small Tensor for Target (1, 18)
        # Note: Tensor is initialized with Zeros by default in C
        oTargetTensor = new Tensor(1, nClasses)
        
        # FIX: Set the One-Hot index directly
        oTargetTensor.setVal(1, nLabelIdx, 1.0)
       
        # Return Pair [Input, Target]
        return [oInTensor, oTargetTensor]