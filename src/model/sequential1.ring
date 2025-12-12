# File: src/model/sequential.ring
# Description: Sequential Model Container with Save/Load support
# Author: Code Gear-1

load "tokenslib.ring"

class Sequential
    aLayers = []

    func add oLayer
        aLayers + oLayer
        return self

    func forward oInput
        oCurrent = oInput
        for oLayer in aLayers
            oCurrent = oLayer.forward(oCurrent)
        next
        return oCurrent

    func backward oGradOutput
        oCurrentGrad = oGradOutput
        for i = len(aLayers) to 1 step -1
            oCurrentGrad = aLayers[i].backward(oCurrentGrad)
        next
        return oCurrentGrad
        
    func getLayers
        return aLayers

    # --- Save & Load Functionality ---

    func saveWeights cFileName
        see "Saving model to " + cFileName + "..." + nl
        
        # 1. Collect all weights/biases into a single flat list
        aAllParams = []
        
        for oLayer in aLayers
            # Check if layer has weights (like Dense)
            if hasParams(oLayer)
                # We save the raw list data (aData), not the Tensor object
                aAllParams + oLayer.oWeights.aData
                aAllParams + oLayer.oBias.aData
            ok
        next
        
        # 2. Serialize and Write
        cData = list2Code(aAllParams)
        write(cFileName, cData)
        see "Done." + nl

    func loadWeights cFileName
        see "Loading model from " + cFileName + "..." + nl
        
        if !fexists(cFileName)
            raise("Error: File not found - " + cFileName)
        ok
        
        # 1. Read and Deserialize
        cData = "aAllParams = " + read(cFileName)

        if checkRingCode([:code = cData]) 
            eval( cData)
        else
            raise("Error: Invalid file format - " + cFileName)
        ok
        
        # 2. Distribute params back to layers
        nIdx = 1
        for oLayer in aLayers
            if hasParams(oLayer)
                # Restore Weights
                if nIdx > len(aAllParams) 
                    raise("Error: Model architecture mismatch (not enough params in file)")
                ok
                oLayer.oWeights.aData = aAllParams[nIdx]
                nIdx++
                
                # Restore Bias
                oLayer.oBias.aData = aAllParams[nIdx]
                nIdx++
            ok
        next
        see "Done." + nl


    private

    # Helper to check if layer is trainable (has weights)
    func hasParams oLayer
        aAttrs = attributes(oLayer)
        bHasW = false
        bHasB = false
        for cAttr in aAttrs
            if lower(cAttr) = "oweights" bHasW = true ok
            if lower(cAttr) = "obias"    bHasB = true ok
        next
        return (bHasW and bHasB)

    

    