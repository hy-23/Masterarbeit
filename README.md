# Masterarbeit
Master thesis repository of Harsha Yogeshappa, RWTH Aachen University.

## Folder heirarchy
```
├───docs
│   ├───Official_Documents                                # All the official documents (including application and confimration).
│   └───Resource_Documents                                # All files gathered across internet that might be relevant for thesis.
│       ├───Books
│       │   ├───PyTorch
│       │   ├───SciPy_and_NumPy
│       │   └───TensorFlow
│       ├───Documents                                     # Documents found to be useful.
│       │   ├───Keynote                                   # Key points and the references .
│       │   ├───Machine_Learning_Mastery                  # Materials from machinelearningmastery.com
│       │   │   └───Figures
│       │   ├───Miscellaneous                             # Files that cannot be specifically categorized.
│       │   │   ├───Images
│       │   │   ├───Pdfs
│       │   │   ├───Txts
│       │   │   └───Xlsx
│       │   └───TensorFlow                                # Files related to TensorFlow.
│       ├───Google_Colab_Programs
│       ├───Latex_Tutorial                                # Tutorial to write a latex file.
│       ├───Research_Papers                               # Research Papers.
│       │   └───Finished
│       └───Thesis_Reports                                # Thesis reports of friends and acquaintances.
│           ├───Bharath
│           └───Muddasser
├───presentations                                         # slides and resources for md file.
│   ├───13.07.2022
│   ├───resources
│   └───Template
├───src                                                   # utility scripts for windows and linux platforms.
│   ├───linux
│   │   └───utils
│   │       ├───py
│   │       └───sh
│   └───windows
│       └───utils
│           ├───matlab
│           ├───py
│           └───sh
└───voxelmorph                                             # Voxelmorph submodule.
    ├───.github
    │   └───ISSUE_TEMPLATE
    ├───data
    ├───scripts
    │   ├───tf
    │   └───torch
    └───voxelmorph
        ├───py
        ├───tf
        │   └───utils
        └───torch
```

## Get the pipeline running.
- **Step1: Perform affine registration using `larvalign_affine` branch on git.**
    1. Use the `larvalign_affine` branch in the "larvalign" repository to perform an affine registration.
    2. In the root directory of "larvalign" repository, you should find a text file named "affine_list.txt".
        - This file contains a list with the full paths of the images that need to be affine registered in the atlas.
        - The result is stored as a zip file in the <output directory>/RegisteredScans/TIFF/
        - Use the python script, `extract-zip.py`, available in "masterarbeit" repository ('D:\Harsha\repo\Masterarbeit\src\windows\utils\py') to extract zip files to folders.
- **Step2: Perform auto scaling to required dimensions using `callAutoScaleImages.m`**
    1. Once the zip files are extracted and folders are available, use the matlab script `callAutoScaleImages.m` to generate macro for Fiji to output a scaled version of the affine aligned tiff images.
- **Step3: Voxelmorph need npz files.**
    1. Use the python script, `create-npz.py`, available in "masterarbeit" repository ('D:\Harsha\repo\Masterarbeit\src\windows\utils\py') to obtain npz files from tif files. **Note:** The values are scaled down between 0.0 and 1.0 as per voxelmorph's requirement.
- **Step4: Once all the npz files are available, prepare a list with the full paths of the images.**
    1. Store the list in the following directory as '/home/students/yogeshappa/repo/Masterarbeit/src/linux/list.txt'
- **Step5: Train the voxelmorph network using the below command.**
    ```py
    /home/students/yogeshappa/miniconda3/bin/python3 /home/students/yogeshappa/repo/Masterarbeit/voxelmorph/scripts/tf/train.py
    --img-list /home/students/yogeshappa/repo/Masterarbeit/src/linux/list.txt
    --atlas /home/students/yogeshappa/repo/Masterarbeit/dataset/atlas/np_atlas_scaled.npz
    --model-dir /work/scratch/yogeshappa/tensorflow_out/model
    --epochs 500
    --steps-per-epoch 66

    # steps_per_epoch = len(training_data) / batch_size.
    # len(training_data) = 66.
    ```
    1. Once the training is complete, save the model weights to later use it for prediction.
- **Step6: Perform nonlinear registration using "larvalign" using `voxelmorph_nonlinear` branch on git.**
    1. Use the `voxelmorph_nonlinear` branch in the "larvalign" repository to perform an affine + nonlinear registration.
    2. In the following directory, "I:\masterarbeit_dataset\data", you must find a text file named "larvalign_list.txt".
        - This file contains a list with the full paths of the images that need to be nonlinear registered in the atlas.
        - The result is stored as a zip file in the <output directory>/RegisteredScans/TIFF/
        - Use the python script, `extract-zip.py`, available in "masterarbeit" repository ('D:\Harsha\repo\Masterarbeit\src\windows\utils\py') to extract zip files to folders.
        - Perform **Step2** for getting folders out of zip files.
- **Step7: Perform nonlinear registration using trained model weights.**
    1. Use the python script, `register_all.py`, available in "masterarbeit" repository ('D:\Harsha\repo\Masterarbeit\src\windows\utils\py') to extract zip files to folders to register all the images.
    2. In the following directory, "I:\masterarbeit_dataset\data", you must find a text file named "voxelmorph_list.txt". Use this to pass to `register_all.py` to give the list with the full paths of the images.
- **Step8: Voxelmorph provides npz files as output.**
    1. Use the python script, `convert-npz-to-mat-all.py`, available in "masterarbeit" repository ('D:\Harsha\repo\Masterarbeit\src\windows\utils\py') to convert all npz files into mat files.
        - The python script expects the path of the file where all npz files are present.
        - The result is stored in the same directory.
    2. Use matlab script, `mat_to_tiff.m`, to convert all .mat variables into a .tif file.
- **Step9: Maximum Intensity Projection for tif files**
    1. For visual evaluation, you need mip files.
    2. Use the matlab script, `traverse_and_find_tif.m`, that recursively traverses the folders, finds tif files and generates mip.
        - This works for 3 channels and 1 channel tiff images.
- **Step10: Visual Evaluation**
    1. Use the matlab script, `visallyEvaluate.m`, to plot fixed image, moving image, registered image, and the overlap of fixed_vs_registered image.
    2. Plot contain results for both Voxelmorph and Larvalign.
        ![alt text](https://github.com/hy-23/Masterarbeit/blob/main/presentations/resources/MAX_np_brain1_scaled.png?raw=true)
