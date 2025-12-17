# File: src/ringml.ring
# Description: Main entry point
# Author: Azzeddine Remmal
# Date: 2025-12-15
# Version: 1.1.0
# License: MIT License

load "stdlib.ring"
load "csvlib.ring"
load "jsonlib.ring"
load "ringtensor.ring"
load "core/tensor.ring"
load "utils/serializer.ring"
load "data/dataset.ring"
load "data/datasplitter.ring"
load "data/universaldataset.ring"
load "utils/visualizer.ring"
load "layers/layer.ring"
load "layers/dense.ring"
load "layers/activation.ring"
load "layers/softmax.ring"
load "layers/dropout.ring" 
load "model/sequential.ring"
load "loss/mse.ring"
load "loss/crossentropy.ring"
load "optim/sgd.ring"
load "optim/adam.ring"         
load "utils/Styler.ring"

oStyl = new Styler()

func RingMLInfo

 oStyl.costom(:BRIGHT_BLUE, :BOLD, "
  _____  _             __  __ _      
 |  __ \(_)           |  \/  | |     
 | |__) |_ _ __   __ _| \  / | |     
 |  _  /| | '_ \ / _` | |\/| | |     
 | | \ \| | | | | (_| | |  | | |____ 
 |_|  \_\_|_| |_|\__, |_|  |_|______|
                  __/ |              
                 |___/               
")
	banner = []
	banner[:topBorder] = colorText([:text = "╭───────────────────────────────────────────────╮", :color = :BRIGHT_BLUE, :style = :BOLD])
	banner[:tEmptyLine] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	
	title = "RingML"
	titlePad = floor((47 - len(title)) / 2)
	banner[:titleLine] = colorText([:text = "│" + space(titlePad), :color = :BRIGHT_BLUE]) + colorText([:text = title, :color = :CYAN, :style = :BOLD]) + colorText([:text = space(47-titlePad-len(title)) + "│", :color = :BRIGHT_BLUE])
	
	banner[:tEmptyLine2] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	
	# Description lines
	desc1 = "High-performance, object-oriented"
	desc1Pad = floor((47 - len(desc1)) / 2)
	banner[:descLine1] = colorText([:text = "│" + space(desc1Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc1, :color = :WHITE]) + colorText([:text = space(47-desc1Pad-len(desc1)) + "│", :color = :BRIGHT_BLUE])
	
	desc2 = "Deep Learning framework"
	desc2Pad = floor((47 - len(desc2)) / 2)
	banner[:descLine2] = colorText([:text = "│" + space(desc2Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc2, :color = :WHITE]) + colorText([:text = space(47-desc2Pad-len(desc2)) + "│", :color = :BRIGHT_BLUE])
	
	desc3 = "built for the Ring programming language."
	desc3Pad = floor((47 - len(desc3)) / 2)
	banner[:descLine3] = colorText([:text = "│" + space(desc3Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc3, :color = :WHITE]) + colorText([:text = space(47-desc3Pad-len(desc3)) + "│", :color = :BRIGHT_BLUE])
	
	banner[:tEmptyLine3] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	
	versionStr = "Version 1.1.0"
	versionPad = floor((47 - len(versionStr)) / 2)
	banner[:versionLine] = colorText([:text = "│" + space(versionPad), :color = :BRIGHT_BLUE]) + colorText([:text = versionStr, :color = :YELLOW, :style = :BOLD]) + colorText([:text = space(47-versionPad-len(versionStr)) + "│", :color = :BRIGHT_BLUE])
	
	authorStr = "Author: Azzeddine Remmal"
	authorPad = floor((47 - len(authorStr)) / 2)
	banner[:authorLine] = colorText([:text = "│" + space(authorPad), :color = :BRIGHT_BLUE]) + colorText([:text = authorStr, :color = :MAGENTA]) + colorText([:text = space(47-authorPad-len(authorStr)) + "│", :color = :BRIGHT_BLUE])
	
	urlStr = "License: MIT License"
	urlPad = floor((47 - len(urlStr)) / 2)
	banner[:urlLine] = colorText([:text = "│" + space(urlPad), :color = :BRIGHT_BLUE]) + colorText([:text = urlStr, :color = :GREEN, :style = :UNDERLINE]) + colorText([:text = space(47-urlPad-len(urlStr)) + "│", :color = :BRIGHT_BLUE])
	
	banner[:bEmptyLine] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	banner[:bottomBorder] = colorText([:text = "╰───────────────────────────────────────────────╯", :color = :BRIGHT_BLUE, :style = :BOLD])
	
	for line in banner
		see line[2] + nl
	next

func RingMLVersion
    see " RingML v - (1.1.0)"

func colorText aParams
	cText = aParams[:text]
	cColor = aParams[:color]
	if not cColor cColor = :WHITE ok
	cStyle = aParams[:style] 
	if not cStyle cStyle = :NONE ok
	return oStyl.costom(cColor, cStyle, cText)