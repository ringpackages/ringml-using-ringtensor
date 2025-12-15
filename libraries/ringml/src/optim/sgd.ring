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
            tensor_update_sgd(oLayer.oWeights.aData, oLayer.oGradWeights.aData, nLearningRate)
        ok

        if variableExists(oLayer, "oBias")
            tensor_update_sgd(oLayer.oBias.aData, oLayer.oGradBias.aData, nLearningRate)
        ok
        
    func variableExists oObj, cVar
        aAttrs = attributes(oObj)
        for cAttr in aAttrs
            if lower(cAttr) = lower(cVar) return true ok
        next
        return false
    