# Observations and Deductions.

## Setup 1:

- **Training Data**: Training with 66 incorrectly<sup>1</sup> affine-aligned image files (DataSetGoodQual, DataSetMediumQual, DataSetRandomQual).
- **Scaled_Down**: Scaled down to 256x512x64 dimensions.
- **Loss Metric**: Mean Square Error.
- **Batch Size**: 1.
- **Epoch**: 223
- **Early Stopping with patience level 3**: Since batch size was 1, the fluctuation in loss was too noisy and early stopping could not work.
- **Time to Predict**: on GPU: ~6-7 seconds.
- **Result**: imshowpair(), model_weight, and mmi values are saved in *Y:\masterarbeit_results\Setup_1*

## Setup 2:
- **Training Data**: Training with 66 correctly affine-aligned image files (DataSetGoodQual, DataSetMediumQual, DataSetRandomQual).
- **Scaled_Down**: Scaled down to 256x512x64 dimensions.
- **Loss Metric**: Mean Square Error.
- **Batch Size**: 1.
- **Epoch**: 300
- **Early Stopping with patience level 3**: Since batch size was 1, the fluctuation in loss was too noisy and early stopping could not work.
- **Time to Predict**: on GPU: ~6-7 seconds.
- **Result**: imshowpair() and mmi values are saved in *Y:\masterarbeit_results\Setup_2*
  - Additionally, nonlinear-registration<sup>2</sup> results are also saved in the directory *lrv_registered* and *vxm_registered*, respectively.

## Setup 3:
- **Training Data**: Training with 66 correctly affine-aligned image files (DataSetGoodQual, DataSetMediumQual, DataSetRandomQual).
- **Scaled_Down**: Scaled down to 256x512x64 dimensions.
- **Loss Metric**: Normalized Cross Correlation.
- **Batch Size**: 1.
- **Epoch**: 238 (loss_ncc = -0.889). The range of loss_ncc should be [0, -1]
- **Early Stopping**: Disabled.
- **Time to Predict**: on GPU: ~6-7 seconds.
- **Result**: The result of the prediction was very poor and easily visible to the naked eye. Therefore, no error measurement was performed. The nonlinear-registered results<sup>3</sup> are saved in *Y:\masterarbeit_results\Setup_3\vxm_registered*

----
1. AtlasImgMedian25.mhd had a DimSize that was 25% of the original size, which sometimes affected the output of affine-aligned images.
2. Input to both "larvalign" and "voxelmorph" are scaled down versions of the affine-aligned images.
3. "larvalign" nonlinear-registered results are same as that in Setup_2.
