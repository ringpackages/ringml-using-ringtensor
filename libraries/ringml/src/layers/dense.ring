# File: src/layers/dense.ring
# Description: Fully Connected (Dense) Layer with Forward & Backward
# Author: Azzeddine Remmal



class Dense from Layer
    oWeights        
    oBias           
    oInput          
    
    oGradWeights    
    oGradBias       

    # Cache for optimization (Reuse pointers)
    oOutputCache            = NULL
    oInputTransposedCache   = NULL
    oWeightsTransposedCache = NULL

    nInputSize
    nNeurons

    func init nIn, nOut
        nInputSize = nIn
        nNeurons   = nOut
        
        # 1. Weights Init
        oWeights = new Tensor(nInputSize, nNeurons)
        
        # Manual Random Init (-1 to 1) using setVal
        for r = 1 to nInputSize
            for c = 1 to nNeurons
                val = (random(2000) / 1000.0) - 1.0
                oWeights.setVal(r, c, val)
            next
        next

        # 2. Bias Init (Small Randoms)
        oBias = new Tensor(1, nNeurons)
        for c = 1 to nNeurons
             val = (random(100) / 10000.0) 
             if val = 0 val = 0.0001 ok
             oBias.setVal(1, c, val)
        next
        
        # 3. Gradients Init
        oGradWeights = new Tensor(nInputSize, nNeurons)
        oGradWeights.zeros()
        oGradBias    = new Tensor(1, nNeurons)
        oGradBias.zeros()
        
    func forward oInputTensor
        oInput = oInputTensor
        
        # 1. MatMul (C-Level Speed)
        # Result is a new Tensor (managed by C)
        oOutput = oInput.matmul(oWeights)
        
        # 2. Add Bias (Broadcasting)
        # Since we don't have "Broadcast Add" in C yet, we use manual loop
        # using getVal/setVal. It is O(N), so it is fast enough.
        
        for r = 1 to oOutput.nRows
            for c = 1 to oOutput.nCols
                # val = old + bias
                val = oOutput.getVal(r, c) + oBias.getVal(1, c)
                oOutput.setVal(r, c, val)
            next
        next
        
        return oOutput

    func backward oGradOutput
        # 1. Gradients for Weights
        # dW = Input^T * GradOutput
        
        if ISNULL(oInputTransposedCache) or oInputTransposedCache.nRows != oInput.nCols
             oInputTransposedCache = oInput.transpose()
        else
             # Update existing cache (Optimization needed in Tensor later)
             # For now, just create new transpose
             oInputTransposedCache = oInput.transpose()
        ok
        
        # We calculate dW directly into oGradWeights
        # Note: Tensor.matmul currently returns NEW tensor.
        # Ideally, we should pass oGradWeights to matmul to avoid allocation.
        # But to keep API simple, we assign the result.
        oGradWeights = oInputTransposedCache.matmul(oGradOutput)
        
        # 2. Gradients for Bias
        # dB = Sum(GradOutput, Axis=0)
        oGradBias = oGradOutput.sum(0) 
        
        # 3. Gradient for Input
        # dInput = GradOutput * Weights^T
        oWeightsTransposedCache = oWeights.transpose()
        dInput = oGradOutput.matmul(oWeightsTransposedCache)
        
        return dInput