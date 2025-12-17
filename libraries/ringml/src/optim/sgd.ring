# File: src/optim/sgd.ring
# Description: Stochastic Gradient Descent Optimizer (Fixed)
# Author: Azzeddine Remmal

class SGD
    nLearningRate = 0.01

    func init nLR
        nLearningRate = nLR

    func update oLayer
        if hasAttribute(oLayer, "bTrainable") 
            if !oLayer.bTrainable return ok
        ok
        
        if variableExists(oLayer, "oWeights")
            tensor_update_sgd(
                oLayer.oWeights.pData, 
                oLayer.oGradWeights.pData, 
                nLearningRate
            )
        ok

        if variableExists(oLayer, "oBias")
            tensor_update_sgd(
                oLayer.oBias.pData, 
                oLayer.oGradBias.pData, 
                nLearningRate
            )
        ok
        
    func variableExists oObj, cVar
        aAttrs = attributes(oObj)
        for cAttr in aAttrs
            if lower(cAttr) = lower(cVar) return true ok
        next
        return false
    
    func hasAttribute oObj, cName
        return variableExists(oObj, cName)
    