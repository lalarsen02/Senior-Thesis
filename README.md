# The Development of a Drum Identification and Transcription Tool

### Senior Thesis | Advised by Dr. Adam Finklestein

This repository contains the code for my Senior Thesis. I used a combination of Convolutional Neural Networks (CNNs) and a 2-layer Hierarchical Encoder-Decoder Transformer to transcribe any drum part automatically.

The Architecture for this Transformer is adapted from **"Automatic Piano Transcription with Hierarchical Frequency-Time Transformer"** presented in ISMIR2023 ([arXiv 2307.04305](https://arxiv.org/abs/2307.04305)).
Github: https://github.com/sony/hFT-Transformer

## Abstract

Automatic Drum Transcription (ADT) is the process of turning audio recordings of percussion instruments into another representation, typically sheet music or a MIDI file. We propose a novel approach to ADT using a CNN and a generic 2-layer Hierarchical Encoder-Decoder Transformer, which analyzes the drum audio in both the frequency and time axis. While other sub-areas of Automatic Music Transcription (AMT) use Transformers like these, ADT still relies heavily on complex, meticulously tuned CNNs. We evaluated the model with the Expanded Midi Groove Dataset (EGMD) and IMST dataset and achieved state-of-the-art results with regard to Drum classification, Onset, Offset, and Velocity Estimations.

## Links

Paper: https://drive.google.com/file/d/1_ULwj0ZJOAs31IouWWK2GiWCPSpDnSaa/view?usp=sharing

Presentation: https://drive.google.com/file/d/12322uD-FLMNvpJ6I-dcg6XqK5BngVymU/view?usp=sharing
