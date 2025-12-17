/*
    Project: RingML (NLP Module)
    File: tokenizer.ring
    Author: Code Gear-1 (Agent)
    Description: A character-level tokenizer for preparing text data for RingGPT/Adam.
*/

class Tokenizer

    # Special Tokens
    cPadToken   = "<PAD>"
    cUnkToken   = "<UNK>"
    cStartToken = "<START>"
    cEndToken   = "<END>"

    # Mappings
    aVocab      = []        # List of characters/tokens
    aTokenToId  = []        # List of [Token, ID] for lookups (Simulating Hash Map)
    nVocabSize  = 0

    func init
        # Initialize with special tokens
        addToken(cPadToken)
        addToken(cUnkToken)
        addToken(cStartToken)
        addToken(cEndToken)
    
    # --- Core Functionality ---

    func build_vocab aTextList
        /*
            Builds vocabulary from a list of strings.
            Currently implements Character-Level tokenization.
        */
        see "Building vocabulary from " + len(aTextList) + " samples..." + nl
        
        # Using a simple list check for uniqueness (O(N^2) but fine for char-level)
        # For word-level, we would need a more optimized hash-map approach in C or clever Ring lists.
        
        for cText in aTextList
            nLen = len(cText)
            for i = 1 to nLen
                cChar = cText[i]
                if not isTokenInVocab(cChar)
                    addToken(cChar)
                ok
            next
        next
        
        see "Vocabulary built. Size: " + nVocabSize + nl
    
    func encode cText
        /*
            Converts a string to a list of integers (IDs).
            Adds <START> and <END> tokens automatically.
        */
        aIds = []
        
        # Add Start Token
        aIds + getTokenId(cStartToken)
        
        nLen = len(cText)
        for i = 1 to nLen
            cChar = cText[i]
            nId = getTokenId(cChar)
            aIds + nId
        next
        
        # Add End Token
        aIds + getTokenId(cEndToken)
        
        return aIds

    func decode aIds
        /*
            Converts a list of integers back to a string.
            Ignores special tokens during reconstruction.
        */
        cText = ""
        for nId in aIds
            cToken = getTokenFromId(nId)
            
            # Skip special tokens in output
            if cToken = cPadToken or cToken = cStartToken or cToken = cEndToken or cToken = cUnkToken
                loop
            ok
            
            cText += cToken
        next
        return cText

    # --- Helper Functions ---

    func addToken cToken
        aVocab + cToken
        aTokenToId + [cToken, len(aVocab)] # 1-based index
        nVocabSize = len(aVocab)

    func isTokenInVocab cToken
        # Linear search (Optimization needed for large vocab)
        for item in aTokenToId
            if item[1] = cToken
                return true
            ok
        next
        return false

    func getTokenId cToken
        for item in aTokenToId
            if item[1] = cToken
                return item[2]
            ok
        next
        return getTokenId(cUnkToken) # Return UNK if not found

    func getTokenFromId nId
        if nId > 0 and nId <= nVocabSize
            return aVocab[nId]
        ok
        return cUnkToken

    # --- Persistence ---

    func saveVocab cFilePath
        /*
            Saves the vocabulary to a file.
            Format: Token|ID per line.
        */
        cContent = ""
        for item in aTokenToId
            cContent += item[1] + "|" + item[2] + nl
        next
        write(cFilePath, cContent)
        see "Vocabulary saved to: " + cFilePath + nl

    func loadVocab cFilePath
        if not fexists(cFilePath)
            see "Error: Vocabulary file not found: " + cFilePath + nl
            return
        ok
        
        cContent = read(cFilePath)
        aLines = str2list(cContent)
        
        # Reset current vocab
        aVocab = []
        aTokenToId = []
        nVocabSize = 0
        
        for cLine in aLines
            if len(trim(cLine)) = 0 loop ok
            
            # Simple parsing assuming | separator
            # Note: This is fragile if tokens contain |. 
            # For char-level it's mostly fine unless '|' is a char.
            # A more robust solution would be JSON or length-prefixed.
            
            # Quick fix for '|' character itself:
            if left(cLine, 2) = "||" 
                cToken = "|"
                nId = number(substr(cLine, 3))
            else
                nPos = substr(cLine, "|")
                if nPos > 0
                    cToken = left(cLine, nPos-1)
                    nId = number(right(cLine, len(cLine)-nPos))
                else
                    loop # Skip malformed
                ok
            ok
            
            aVocab + cToken
            aTokenToId + [cToken, nId]
        next
        nVocabSize = len(aVocab)
        see "Vocabulary loaded. Size: " + nVocabSize + nl