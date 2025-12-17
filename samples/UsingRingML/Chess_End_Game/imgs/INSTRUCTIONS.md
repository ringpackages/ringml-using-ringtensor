# ♟️ RingML Chess AI Engine: User Guide

This application demonstrates the power of **RingML** by turning a trained Neural Network into a functional Chess Engine. It doesn't just classify positions; it actively searches for the best move to checkmate the Black King.

## 📋 Prerequisites

Before running the application, ensure you have the following directory structure and files:

1.  **Model:** The trained model file `chess_universal.rdata` must exist inside the `model/` folder.
    *   *Note: This model was trained using the UniversalDataset method with Data Splitting.*
2.  **Images:** A folder named `imgs/` containing the piece assets:
    *   `WKing.png`, `WRook.png`, `BKing.png`
3.  **Library:** The `src/` folder of RingML must be accessible.

## 🚀 How to Run

Execute the application from the command line:

```bash
ring chess_ai_tool.ring
```

## 🎮 How to Use

The application features a graphical interface divided into two sections: **Control Panel** (Left) and **Chess Board** (Right).

### 1. Setup the Board
Use the dropdown menus on the left to place the three pieces on the board:
*   **♔ White King:** Select File (a-h) and Rank (1-8).
*   **♖ White Rook:** Select File (a-h) and Rank (1-8).
*   **♚ Black King:** Select File (a-h) and Rank (1-8).

*The board on the right will update instantly to reflect your setup.*

### 2. The "AI Move" Button
Click the **🤖 AI Move** button to let the Neural Network decide the next move.

### 3. Interpreting Results
The AI performs two actions:
1.  **Move Execution:** It moves the White piece (King or Rook) on the graphical board.
    *   🟨 **Yellow Square:** The position the piece moved *from*.
    *   🟩 **Green Square:** The position the piece moved *to*.
2.  **Status Report:**
    *   **Prediction:** Displays the expected game outcome (e.g., *Mate in Two*, *Draw*).
    *   **Confidence:** The probability percentage of that outcome.
    *   **Log:** Displays the text description of the move (e.g., *"Best Move: WR to a7"*).

---

## 🧠 How It Works (The Logic)

This is not a traditional chess engine based on Minimax or Alpha-Beta pruning. It is a **Neural-Guided Engine**:

1.  **State Analysis:** When you click the button, the app reads the current coordinates of the pieces.
2.  **Move Generation:** It calculates all legal moves for the White King and White Rook (one step ahead).
3.  **Neural Evaluation:**
    *   For *every possible move*, it creates a new "Hypothetical Board State".
    *   It feeds this state into the **RingML Tensor** and passes it through the loaded neural network (`chess_universal.rdata`).
4.  **Decision Making:**
    *   The model predicts how close White is to winning for each move (0 moves = Mate, 16 moves = Far).
    *   The engine selects the move that minimizes the "Distance to Mate" (i.e., looks for the fastest win) while avoiding Draws.

This demonstrates that a generic Neural Network built with **RingML** can "understand" the rules and strategy of a complex game simply by learning from data.