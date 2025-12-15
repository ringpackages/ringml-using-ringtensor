# File: src/core/tensor.ring
# Description: Core Tensor class - Updated for Adam Optimizer
# Author: Azzeddine Remmal



func Randomize(nSeed)
    return Random(nSeed)

class Tensor
    aData   = []    
    nRows   = 0     
    nCols   = 0     

    func init nR, nC
        self.nRows = nR
        self.nCols = nC
        
        # Initialize list structure (List of Lists)
        aData = list(self.nRows)
        for i = 1 to self.nRows
            aData[i] = list(self.nCols)
            # Init to 0.0 to ensure float type
            for j = 1 to self.nCols aData[i][j] = 0.0 next
        next
        return self
        
    func copy
        # Create a new independent Tensor instance
        oNew = new Tensor(nRows, nCols)
        for r = 1 to nRows
            oNew.aData[r] = aData[r] 
        next
        return oNew

    # --- Initialization ---

    func random
        # Uniform random 0.0 to 1.0 (C-Level)
        tensor_random(aData)
        return self

    func zeros
        tensor_fill(aData, 0.0)
        return self

    func fill nVal
        tensor_fill(aData, nVal)
        return self

    # --- Math Operations (Element-Wise) ---
    
    func add oTensor
        checkDimensions(oTensor)
        tensor_add(aData, oTensor.aData)
        return self

    func sub oTensor
        checkDimensions(oTensor)
        tensor_sub(aData, oTensor.aData)
        return self

    func mul oTensor
        checkDimensions(oTensor)
        # Element-wise Multiplication (Hadamard Product)
        tensor_mul_elem(aData, oTensor.aData)
        return self
        
    func div oTensor
        checkDimensions(oTensor)
        # Element-wise Division with zero safety
        tensor_div(aData, oTensor.aData)
        return self

    # --- Scalar Operations ---

    func scalar_mul nVal
        tensor_scalar_mul(aData, nVal)
        return self
        
    func add_scalar nVal
        tensor_add_scalar(aData, nVal)
        return self

    # --- Transformations ---

    func square
        tensor_square(aData)
        return self
    
    func sqrt
        tensor_sqrt(aData)
        return self
        
    func exp_func
        tensor_exp(aData)
        return self

    # --- Reductions ---

    func mean
        # Returns a Number
        return tensor_mean(aData)

    func sum nAxis
        # tensor_sum(List, Axis) -> Returns New List structure
        # Axis 1 = Sum Rows (Result: Rows x 1)
        # Axis 0 = Sum Cols (Result: 1 x Cols)
        newData = tensor_sum(aData, nAxis)
        
        if nAxis = 1 
            oRes = new Tensor(nRows, 1)
        else
            oRes = new Tensor(1, nCols)
        ok
        
        oRes.aData = newData
        return oRes

    # --- Matrix Operations ---

    func matmul oTensor
        if self.nCols != oTensor.nRows
            raise("Dimension Mismatch in MatMul")
        ok
        
        # C Function returns new list
        newData = tensor_matmul(aData, oTensor.aData)
        
        oRes = new Tensor(nRows, oTensor.nCols)
        oRes.aData = newData
        return oRes

    func transpose
        # C Function returns new list
        newData = tensor_transpose(aData)
        
        # Update self with new data and swapped dimensions
        aData = newData
        nTemp = nRows
        nRows = nCols
        nCols = nTemp
        return self

    # --- Activations ---
    
    func sigmoid
        tensor_sigmoid(aData)
        return self

    func sigmoid_prime
        tensor_sigmoid_prime(aData)
        return self

    func relu
        tensor_relu(aData)
        return self
        
    func relu_prime
        tensor_relu_prime(aData)
        return self
        
    func tanh
        tensor_tanh(aData)
        return self    

    func tanh_prime
        tensor_tanh_prime(aData)
        return self

    func softmax
        # Numerically Stable Softmax (C-Level)
        tensor_softmax(aData)
        return self

    # --- Regularization ---

    func apply_dropout nRate
        tensor_dropout(aData, nRate)
        return self

    # --- Utilities ---
    
    func print_shape
        see "(" + nRows + ", " + nCols + ")" + nl

    func decimals nPlaces
        # Helper for display formatting only
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
            raise("Dimension Mismatch: (" + nRows + "," + nCols + ") vs (" + oTensor.nRows + "," + oTensor.nCols + ")")
        ok

    func print
        see "Tensor Shape: (" + nRows + ", " + nCols + ")" + nl
        if nRows <= 10 and nCols <= 10
            for h = 1 to nRows
                See "| "
                for v = 1 to nCols
                    Num = aData[h][v]
                    if (Num >= 0) See " " ok
                    See Num  
                    if v != nCols   See "," ok
                next
                See " |" + nl
            next
            See nl
        else
            see "Data is too large to display." + nl
        ok
        see nl