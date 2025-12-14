aPackageInfo = [
	:name = "The RingML Package",
	:description = "Our RingML package using the Ring programming language",
	:folder = "RingML",
	:developer = "Azzeddine Remmal",
	:email = "azzeddine.remmal@gmail.com",
	:license = "MIT License",
	:version = "1.0.5",
	:ringversion = "1.24",
	:versions = 	[
		[
			:version = "1.0.5",
			:branch = "master"
		]
	],
	:libs = 	[
		[
			:name = "stdlib.ring",
			:version = "1.0.22",
			:providerusername = ""
		],
		[
			:name = "consolecolors.ring",
			:version = "1.0.7",
			:providerusername = ""
		],
		[
			:name = "fastpro.ring",
			:version = "1.0.8",
			:providerusername = ""
		]
	],
	:files = 	[
		"lib.ring",
		"main.ring",
		"examples/Chess_End_Game/chess_app.ring",
		"examples/Chess_End_Game/chess_dataset.ring",
		"examples/Chess_End_Game/chess_final_model.ring",
		"examples/Chess_End_Game/chess_train_adam.ring",
		"examples/Chess_End_Game/chess_train_batch.ring",
		"examples/Chess_End_Game/chess_train_fast.ring",
		"examples/Chess_End_Game/chess_train_lite.ring",
		"examples/Chess_End_Game/chess_train_split.ring",
		"examples/Chess_End_Game/chess_utils.ring",
		"examples/Chess_End_Game/data/chess.csv",
		"examples/classify_demo.ring",
		"examples/classify_demo2.ring",
		"examples/fast_viz_demo.ring",
		"examples/loader_demo.ring",
		"examples/mnist/data/mnist_test.csv",
		"examples/mnist/mnist_app.ring",
		"examples/mnist/mnist_dataset.ring",
		"examples/mnist/mnist_train.ring",
		"examples/mnist/mnist_train_split.ring",
		"examples/README.md",
		"examples/save_load_demo.ring",
		"examples/test.ring",
		"examples/xor_train.ring",
		"project_documents/RingML/FastPro_Fix_Roadmap.md",
		"project_documents/RingML/FastPro_Technical_Report.md",
		"project_documents/RingML/README.md",
		"project_documents/RingML/uml/class_diagram.md",
		"README.md",
		"src/core/tensor.ring",
		"src/data/dataset.ring",
		"src/data/datasplitter.ring",
		"src/layers/activation.ring",
		"src/layers/dense.ring",
		"src/layers/dropout.ring",
		"src/layers/layer.ring",
		"src/layers/softmax.ring",
		"src/loss/crossentropy.ring",
		"src/loss/mse.ring",
		"src/model/sequential.ring",
		"src/optim/adam.ring",
		"src/optim/sgd.ring",
		"src/ringml.ring",
		"src/utils/serializer.ring",
		"src/utils/visualizer.ring",
		"tests/test_dims.ring",
		"tests/test_init.ring",
		"tests/test_signs.ring",
		"tests/test_step1.ring",
		"tests/test_step2.ring",
		"tests/test_step3.ring",
		"tests/test_step4.ring",
		"tests/test_sub.ring"
	],
	:ringfolderfiles = 	[

	],
	:windowsfiles = 	[

	],
	:linuxfiles = 	[

	],
	:ubuntufiles = 	[

	],
	:fedorafiles = 	[

	],
	:freebsdfiles = 	[

	],
	:macosfiles = 	[

	],
	:windowsringfolderfiles = 	[

	],
	:linuxringfolderfiles = 	[

	],
	:ubunturingfolderfiles = 	[

	],
	:fedoraringfolderfiles = 	[

	],
	:freebsdringfolderfiles = 	[

	],
	:macosringfolderfiles = 	[

	],
	:run = "ring main.ring",
	:windowsrun = "",
	:linuxrun = "",
	:macosrun = "",
	:ubunturun = "",
	:fedorarun = "",
	:setup = "",
	:windowssetup = "",
	:linuxsetup = "",
	:macossetup = "",
	:ubuntusetup = "",
	:fedorasetup = "",
	:remove = "",
	:windowsremove = "",
	:linuxremove = "",
	:macosremove = "",
	:ubunturemove = "",
	:fedoraremove = ""
]