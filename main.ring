# The Main File

load "lib.ring"

func main

	? "
  _____  _             __  __ _      
 |  __ \(_)           |  \/  | |     
 | |__) |_ _ __   __ _| \  / | |     
 |  _  /| | '_ \ / _` | |\/| | |     
 | | \ \| | | | | (_| | |  | | |____ 
 |_|  \_\_|_| |_|\__, |_|  |_|______|
                  __/ |              
                 |___/               
"
	? "RingML - Machine Learning Library for Ring"
	? "Version   : 1.0.5"
	? "Developer : Azzeddine Remmal"
	? "License   : MIT License"
	? ""
	? "========================================="
	? "           QUICK START GUIDE             "
	? "========================================="
	? "1. Data Preparation:"
	? "   Use DataSplitter to handle raw CSV data and DataLoader for batching."
	? "   see examples/loader_demo.ring"
	? ""
	? "2. Building the Model:"
	? "   Construct a model using Tanh for hidden layers and Dropout for regularization."
	? "   model = new Sequential"
	? "   model.add(new Dense(10, 64))"
	? "   model.add(new Tanh)"
	? "   model.add(new Dropout(0.2))"
	? "   model.add(new Dense(64, 3))"
	? "   model.add(new Softmax)"
	? ""
	? "3. Training:"
	? "   Use Adam or SGD optimizers."
	? "   see examples/mnist/mnist_train.ring"
	? ""
	? "========================================="
	? "              EXAMPLES                   "
	? "========================================="
	? "Find ready-to-run examples in the 'examples' folder:"
	? "- examples/xor_train.ring          : Binary Classification (XOR)"
	? "- examples/classify_demo.ring      : Multi-Class Classification"
	? "- examples/mnist/mnist_train.ring  : MNIST Digit Recognition"
	? "- examples/Chess_End_Game/         : Full Real-world Project"
	? ""
	? "Run an example:"
	? "ring xor_train.ring"