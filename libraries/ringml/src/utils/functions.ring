# File: functions.ring
# Description: Helper functions for RingML.
# Author: Azzeddine Remmal



# ============================================================================
# Function: hasAttribute
# Description: Checks if an object has a specific attribute.	
# ============================================================================
func hasAttribute oObj, cName
        aAttrs = attributes(oObj)
        for a in aAttrs
            if lower(a) = lower(cName) return true ok
        next
        return false
# ============================================================================
# Function: Randomize
# Description: Initializes the random number generator with a seed.
# ============================================================================
func Randomize(nSeed)
    return Random(nSeed)

# ============================================================================
# Function: listToTensor
# Description: Converts a list to a Tensor.
# ============================================================================
func listToTensor aList
    nRows = len(aList)
    if nRows = 0 return new Tensor(1,1) ok
    nCols = len(aList[1])
    
    oTen = new Tensor(nRows, nCols)
    
    for r = 1 to nRows
        for c = 1 to nCols
            oTen.setVal(r, c, aList[r][c])
        next
    next
    return oTen


func variableexists



