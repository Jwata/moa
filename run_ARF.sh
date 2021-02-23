#!/bin/bash

N=$1 # number of threads

tree_learner="(
  ARFHoeffdingTree \
  -memoryEstimatePeriod 2000000 \
  -binarySplits \
  -noPrePrune \
  -splitConfidence 0.05 \
  -tieThreshold 0.0 \
  -leafprediction MC \
)"
learner="(
  meta.AdaptiveRandomForest \
  -numberOfJobs $N \
  -ensembleSize 100 \
  -mFeaturesMode (Specified m (integer value)) \
  -lambda 1.0 \
  -driftDetectionMethod (ADWINChangeDetector -a 0.001) \
  -warningDetectionMethod (ADWINChangeDetector -a 0.001) \
  -disableWeightedVote \
  -disableBackgroundLearner \
  -treeLearner $tree_learner \
)"
task="EvaluatePrequential \
  -stream generators.RandomTreeGenerator \
  -instanceLimit 100000 \
  -sampleFrequency 10000 \
  -learner $learner"

java -cp `pwd`/moa/target/moa-2020.12.1-SNAPSHOT.jar \
     -javaagent:./lib/sizeofag-1.0.5.jar \
     moa.DoTask $task
