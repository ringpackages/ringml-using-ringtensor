# File: src/core/tensor.ring
# Description: Core Tensor class - Updated for Adam Optimizer
# Author: Code Gear-1

load "fastpro.ring"

class Tensor
    aData   = []    
    nRows   = 0     
    nCols   = 0     

    func init nR, nC
        self.nRows = nR
        self.nCols = nC
        aData = list(self.nRows)
        for i = 1 to self.nRows
            aData[i] = list(self.nCols)
        next
        return self
        
    func copy
        oNew = new Tensor(nRows, nCols)
        for r = 1 to nRows
            oNew.aData[r] = aData[r] 
        next
        return oNew

    # --- Initialization ---
    func random
        updateList(aData, :random, :matrix)
        return self

    func zeros
        aData = updateList(aData, :zerolike, :matrix)
        return self

    func fill nVal
        aData = updateList(aData, :fill, :matrix, nVal)
        return self

    # --- Math Operations ---
    
    func add oTensor
        checkDimensions(oTensor)
        aData = updateList(aData, :add, :matrix, oTensor.aData)
        return self

    # New: Add Scalar (For Epsilon in Adam)
    func add_scalar nVal
        # FastPro Case 205: Add to Items
        updateList(aData, :add, :items, nVal)
        return self

    func sub oTensor
        checkDimensions(oTensor)
        aData = updateList(aData, :sub, :matrix, oTensor.aData)
        return self

    func mul oTensor
        checkDimensions(oTensor)
        # Using manual loop until :emul is fully deployed
        for r = 1 to nRows
             for c = 1 to nCols
                 aData[r][c] *= oTensor.aData[r][c]
             next
        next
        return self

    # New: Element-Wise Division (For Adam)
    func div oTensor
        checkDimensions(oTensor)
        for r = 1 to nRows
             for c = 1 to nCols
                 # Avoid division by zero check if handled by epsilon outside
                 aData[r][c] /= oTensor.aData[r][c]
             next
        next
        return self

    func scalar_mul nVal
        aData = updateList(aData, :scalar, :matrix, nVal)
        return self

    func sum nAxis
        newData = updateList(aData, :sum, :matrix, nAxis)
        if nAxis = 1 
            oRes = new Tensor(nRows, 1)
        else
            oRes = new Tensor(1, nCols)
        ok
        oRes.aData = newData
        return oRes
        
    func square
        aData = updateList(aData, :square, :matrix)
        return self
    
    # New: Square Root (For Adam)
    func sqrt
        # FastPro Case 2206
        aData = updateList(aData, :sqrt, :matrix)
        return self
        
    func mean
        nRes = updateList(aData, :mean, :matrix)
        return nRes

    func exp_func
        for r = 1 to nRows
            for c = 1 to nCols
                aData[r][c] = exp(aData[r][c])
            next
        next
        return self

    # --- Matrix Operations ---
    func matmul oTensor
        if self.nCols != oTensor.nRows
            raise("Dimension Mismatch in MatMul")
        ok
        newData = updateList(aData, :mul, :matrix, oTensor.aData)
        oRes = new Tensor(self.nRows, oTensor.nCols)
        oRes.aData = newData
        return oRes

    func transpose
        aData = updateList(aData, :transpose, :matrix)
        nTemp = nRows
        nRows = nCols
        nCols = nTemp
        return self

    # --- Activations ---
    func sigmoid
        aData = updateList(aData, :sigmoid, :matrix)
        return self

    func sigmoid_prime
        aData = updateList(aData, :sigmoidprime, :matrix)
        return self

    func relu
        aData = updateList(aData, :relu, :matrix)
        return self
        
    func relu_prime
        aData = updateList(aData, :reluprime, :matrix)
        return self
        
    func tanh
        aData = updateList(aData, :tanh, :matrix)
        return self

    func softmax
        aData = updateList(aData, :softmax, :matrix)
        return self

    # --- Utilities ---
    func print_shape
        see "(" + nRows + ", " + nCols + ")" + nl

    func decimals nPlaces
        for r = 1 to nRows
            for c = 1 to nCols
                nFactor = pow(10, nPlaces)
                val = floor(aData[r][c] * nFactor) / nFactor
                aData[r][c] = val
            next
        next
        return self

    func checkDimensions oTensor
        if nRows != oTensor.nRows or nCols != oTensor.nCols
            raise("Dimension Mismatch")
        ok

    func print
        see "Tensor Shape: (" + nRows + ", " + nCols + ")" + nl
        if nRows <= 10 and nCols <= 10
            see aData
        else
            see "Data is too large to display." + nl
        ok
        see nl