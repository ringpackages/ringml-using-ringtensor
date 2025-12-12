# File: src/ringml.ring
# Description: Main entry point for RingML library

load "fastpro.ring"
load "core/tensor.ring"
load "utils/serializer.ring"
load "data/dataset.ring"
load "layers/layer.ring"
load "layers/dense.ring"
load "layers/activation.ring"
load "layers/softmax.ring"
load "model/sequential.ring"
load "loss/mse.ring"
load "loss/crossentropy.ring"
load "optim/sgd.ring"

func RingML_Info
    see "RingML Library v1.3 - High Precision IO" + nl