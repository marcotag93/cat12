## cat12

# MRI Normalization Pipeline

This script provides a bash command-line interface for normalizing T1-weighted MRI images into the MNI152 space using MATLAB's SPM12 and CAT12 toolboxes. It supports options to perform brain extraction and/or coregistration with a reference image. 
The script uses MATLAB functions located in the same directory of the main script. 

## Requirements

- MATLAB
- SPM12
- CAT12

## Installation

1. Clone the repository:
```bash
https://github.com/marcotag93/cat12.git
```

3. Change the `SPM12_DIR` variable in the script to point to your SPM12 installation path.

## Usage

Run the script with the following syntax:

```bash
./cat12 [path_to_image] [options]
```

Options

    --bet: Perform brain extraction without normalization.
    --coreg [path_to_reference_image]: Perform coregistration of the image with a reference image.

Example:
./cat12 /path/to/image.nii --bet

Notes

    The path SPM12_DIR inside the main script must be changed with the correct one for your system. 
    The CAT12 folder should be saved inside the SPM12 toolbox folder, as the CAT12 documentation suggests.
    The image file must be in NIfTI format (.nii).

