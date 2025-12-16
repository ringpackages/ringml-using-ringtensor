# File: src/loss/crossentropy.ring
# Description: Cross Entropy Loss
# Author: Azzeddine Remmal


class CrossEntropyLoss
    
    func forward oPred, oTarget
        nTotalLoss = 0
        nBatch = oPred.nRows
        nClasses = oPred.nCols
        
        for r = 1 to nBatch
            for c = 1 to nClasses
                # FIX: Use getVal accessors
                pred = oPred.getVal(r, c)
                target = oTarget.getVal(r, c)
                npred = 0.000000000000001
                if pred < npred pred = npred ok
                if pred > (1.0 - npred) pred = 1.0 - npred ok
                
                if target = 1
                    nTotalLoss -= log(pred)
                ok
            next
        next
        
        return nTotalLoss / nBatch

    func backward oPred, oTarget
        # Gradient = (Pred - Target) / BatchSize
        oGrad = oPred.copy()
        oGrad.sub(oTarget)
        
        nTotal = oPred.nRows 
        oGrad.scalar_mul(1.0 / nTotal)
        
        return oGrad