# File: src/optim/adam.ring
# Description: Adam Optimizer (Adaptive Moment Estimation)
# Author: Code Gear-1

class Adam
    nLR = 0.001
    nBeta1 = 0.9
    nBeta2 = 0.999
    nEpsilon = 0.00000001
    
    # Time step
    t = 0

    func init nLearningRate
        nLR = nLearningRate

    func update oLayer
        # Increment time step once per update cycle
        # Note: Ideally t should be global per epoch/batch, 
        # but incrementing per layer call is slightly wrong logic if we don't sync.
        # However, for simplicity in this architecture, we'll manage t internally or passed.
        # Let's handle 't' inside the parameter update logic.
        
        # Check if layer has trainable parameters
        if !hasAttribute(oLayer, "oWeights") return ok

        # --- Initialize Adam State for this Layer if not exists ---
        if !hasAttribute(oLayer, "adam_mw")
            # We attach state variables dynamically to the layer object
            
            # First Moment (m) and Second Moment (v) for Weights
            addAttribute(oLayer, "adam_mw")
            addAttribute(oLayer, "adam_vw")
            oLayer.adam_mw = oLayer.oWeights.copy().zeros()
            oLayer.adam_vw = oLayer.oWeights.copy().zeros()
            
            # First Moment (m) and Second Moment (v) for Bias
            addAttribute(oLayer, "adam_mb")
            addAttribute(oLayer, "adam_vb")
            oLayer.adam_mb = oLayer.oBias.copy().zeros()
            oLayer.adam_vb = oLayer.oBias.copy().zeros()
            
            # Local timestep counter for this layer
            addAttribute(oLayer, "adam_t")
            oLayer.adam_t = 0
        ok

        # Increment time for this layer
        oLayer.adam_t++
        local_t = oLayer.adam_t

        # Update Weights
        updateParameter(oLayer.oWeights, oLayer.oGradWeights, oLayer.adam_mw, oLayer.adam_vw, local_t)

        # Update Bias
        updateParameter(oLayer.oBias, oLayer.oGradBias, oLayer.adam_mb, oLayer.adam_vb, local_t)

    func updateParameter oParam, oGrad, oM, oV, nT
        # 1. Update biased first moment estimate
        # m = beta1 * m + (1 - beta1) * g
        oM.scalar_mul(nBeta1)
        
        oGradPart = oGrad.copy()
        oGradPart.scalar_mul(1.0 - nBeta1)
        oM.add(oGradPart)

        # 2. Update biased second raw moment estimate
        # v = beta2 * v + (1 - beta2) * g^2
        oV.scalar_mul(nBeta2)
        
        oGradSq = oGrad.copy()
        oGradSq.square() # g^2
        oGradSq.scalar_mul(1.0 - nBeta2)
        oV.add(oGradSq)

        # 3. Compute bias-corrected first moment estimate
        # m_hat = m / (1 - beta1^t)
        correction1 = 1.0 - pow(nBeta1, nT)
        oMHat = oM.copy()
        oMHat.scalar_mul(1.0 / correction1)

        # 4. Compute bias-corrected second raw moment estimate
        # v_hat = v / (1 - beta2^t)
        correction2 = 1.0 - pow(nBeta2, nT)
        oVHat = oV.copy()
        oVHat.scalar_mul(1.0 / correction2)

        # 5. Update parameters
        # p = p - lr * m_hat / (sqrt(v_hat) + epsilon)
        
        # Prepare Denominator: sqrt(v_hat) + epsilon
        oDenom = oVHat.sqrt()
        oDenom.add_scalar(nEpsilon)
        
        # Calculate Step: m_hat / denom
        oStep = oMHat.copy()
        oStep.div(oDenom)
        
        # Apply Learning Rate
        oStep.scalar_mul(nLR)
        
        # Update original parameter
        oParam.sub(oStep)

    func hasAttribute oObj, cName
        aAttrs = attributes(oObj)
        for a in aAttrs
            if lower(a) = lower(cName) return true ok
        next
        return false