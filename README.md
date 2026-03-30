# cat12

## MRI Normalization Pipeline

A bash command-line interface for normalizing T1-weighted MRI images into MNI152 space using MATLAB's SPM12 and CAT12 toolboxes. Supports brain extraction (BET) and coregistration with a reference image.

## Requirements

- MATLAB
- [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)
- [CAT12](http://www.neuro.uni-jena.de/cat/) (installed inside the SPM12 `toolbox` folder)

### Optional (for .nii.gz to .nii conversion)

One of the following is required if input images are in `.nii.gz` format:

- [MRtrix3](https://www.mrtrix.org/) (`mrconvert`)
- [FSL](https://fsl.fmrib.ox.ac.uk/fsl/) (`fslchfiletype`)
- `gzip` (available on most systems)

## Installation

1. Clone the repository:

```bash
git clone https://github.com/marcotag93/cat12.git
```

2. Set the SPM12 path using one of:

   - Environment variable (recommended):

   ```bash
   export SPM12_DIR=/path/to/spm12
   ```

   - Edit the `SPM12_DIR` variable directly in the `cat12` script.

The CAT12 folder must be inside `$SPM12_DIR/toolbox/cat12/`, as described in the CAT12 documentation.

## Usage

```bash
./cat12 <path_to_image.nii> [options]
```

The input image must be in NIfTI format (`.nii` or `.nii.gz`).

### Options

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show help message. |
| `--bet` | Brain extraction only (no normalization). |
| `--coreg <ref.nii>` | Coregister input to a reference image. |
| `--nproc N` | Number of parallel processes (default: all available cores). |
| `--vox V` | Isotropic voxel size in mm for normalization (default: 1.5). |
| `--no-surface` | Disable surface extraction during normalization. |

### Examples

Normalize a T1w image to MNI152 space:

```bash
./cat12 /path/to/sub-01_T1w.nii
```

Brain extraction only:

```bash
./cat12 /path/to/sub-01_T1w.nii --bet
```

Coregister to a reference image:

```bash
./cat12 /path/to/sub-01_T1w.nii --coreg /path/to/reference.nii
```

Normalize with custom voxel size and no surface extraction:

```bash
./cat12 /path/to/sub-01_T1w.nii --vox 1.0 --no-surface
```

Using environment variable for SPM12 path:

```bash
SPM12_DIR=/opt/spm12 ./cat12 /path/to/sub-01_T1w.nii
```

## Notes

- Normalization includes cortical surface extraction by default. Use `--no-surface` to disable it and reduce processing time.
- Output files are written to the `mri` subfolder relative to the input image, following CAT12 conventions.

## How to Cite

If you use this pipeline in your research, please cite the underlying tools:

**CAT12**

Gaser, C., Dahnke, R., Thompson, P. M., Kurth, F., Luders, E., & the Alzheimer's Disease Neuroimaging Initiative. (2024). CAT -- A Computational Anatomy Toolbox for the Analysis of Structural MRI Data. *GigaScience*, 13, giae049. https://doi.org/10.1093/gigascience/giae049

**SPM12**

Penny, W. D., Friston, K. J., Ashburner, J. T., Kiebel, S. J., & Nichols, T. E. (Eds.). (2007). *Statistical Parametric Mapping: The Analysis of Functional Brain Images*. Academic Press. https://doi.org/10.1016/B978-0-12-372560-8.X5000-1
