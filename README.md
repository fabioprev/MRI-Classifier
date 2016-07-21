AlzheimerClassifier
=========

Thank you for using our AlzheimerClassifier software. In the case you downloaded empty directiories
here the solution to fix your problem. Since the Github repository contains sub-modules you need to
recursively download it by typing the following command:
  
  - cd \<AlzheimerClassifier-root\>
  - cd ..
  - rm -rf AlzheimerClassifier
  - git clone --recursive https://github.com/fabioprev/AlzheimerClassifier

While for pulling the latest modifications to any of the sub-modules, type in the terminal:
  
  - cd \<AlzheimerClassifier-root\>
  - git pull
  - git submodule foreach git pull origin master

# Usage

Running the software is easy and straightforward. We now describe a quick guide on how to
use the software, but a specific guide for each software package can be found in the
README.md file contained in the root directory of the software package.

1. We first need to organize the data set we want to use based on the patient's
   categories (i.e., AD, CN, LMCI, MCI). In order to do so, we have to type the 
   following command:
   
      - cd \<DatasetOrganizer-root\>/bin
      - ./DatasetOrganizer -d \<directory-root\>

2. Afterwards, we have to extract the MRI patient brain scans from the data we
   organized. We therefore use the ImageExtractor software package to do this task.
   The code has been developed by using Matlab 2012b but the code should be compatible
   also with newer Matlab versions. Open Matlab and import the ImageExtractor software
   package. Then type the following command:
   
      - imageExtractor(\<dataset-name\>,\<dataset-path\>) - e.g., imageExtractor('adni','/home/fabio/IASI-CNR/Datasets/ADNI/')

3. Now we are ready to extract ORB features from the patient MRI scans and to generate the
   CSV files for the classifier algorithm. Remember to set the correct parameters of the
   algorithm before running the code (see README.md in FeatureExtractor). Once the parameters
   have been set type the following command:
   
      - cd \<FeatureExtractor\>/bin
      - ./FeatureExtractor -d \<directory-root\>

4. If features have been correctly extracted from the MRI scans you should find a directory
   called 'ClassPatientFiles' in the root directory of the data set chosen. Now, before using
   the CSV files with Weka, we need to generate a set of files, each one having a possible
   combination of patient's disease (e.g., ADvsCN, ADvsCNvsMCI, CNvsMCI, ...).

5. The last step is open Weka, set the desidered parameters of the classifier and run it
   using one of the file generated at the previous point. We found that LIBSVM is the most
   performing classifier for this kind of task.
   
For any problem/question/suggestion please send an email to previtali@dis.uniroma1.it and
we will be glad to help you!
