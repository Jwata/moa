#!/bin/bash

tree_learner="(
  ARFHoeffdingTree\
  -subspaceSizeSize 60\
  -memoryEstimatePeriod 2000000\
  -gracePeriod 1000\
  -splitConfidence 0.05\
  -tieThreshold 0.0\
  -binarySplits\
  -noPrePrune\
  -leafprediction MC\
)"
learner="(
  meta.AdaptiveRandomForest\
  -numberOfJobs 1\
  -ensembleSize 100\
  -mFeaturesMode (Specified m (integer value))\
  -mFeaturesPerTreeSize 100\
  -driftDetectionMethod (ADWINChangeDetector -a 0.001)\
  -warningDetectionMethod (ADWINChangeDetector -a 0.01)\
  -treeLearner $tree_learner\
)"
task="EvaluatePrequential\
  -stream generators.RandomTreeGenerator\
  -instanceLimit 100000\
  -sampleFrequency 10000\
  -learner $learner"

java -cp `pwd`/moa/target/moa-2020.12.1-SNAPSHOT.jar \
     -javaagent:sizeofag-1.0.4.jar \
     moa.DoTask $task
