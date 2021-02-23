#!/bin/bash

tree_learner="(
  ARFHoeffdingTree\
)"
learner="(
  meta.AdaptiveRandomForest\
  -numberOfJobs $N\
  -ensembleSize 100\
  -mFeaturesMode (Specified m (integer value))\
  -treeLearner $tree_learner\
)"
task="EvaluatePrequential\
  -stream generators.RandomTreeGenerator\
  -instanceLimit 100000\
  -sampleFrequency 10000\
  -learner $learner"

java -cp `pwd`/moa/target/moa-2020.12.1-SNAPSHOT.jar \
     -javaagent:./lib/sizeofag-1.0.5.jar \
     moa.DoTask $task
