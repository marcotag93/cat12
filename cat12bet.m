function cat12bet(t1w_src, spm12_dir, nproc)

    narginchk(2, 3);

    if ~ischar(t1w_src) || ~exist(t1w_src, 'file')
        error('cat12bet:invalidInput', 'Input image not found: %s', t1w_src);
    end
    if ~ischar(spm12_dir) || ~exist(spm12_dir, 'dir')
        error('cat12bet:invalidInput', 'SPM12 directory not found: %s', spm12_dir);
    end

    if nargin < 3 || isempty(nproc)
        nproc = feature('numcores');
    end

    addpath(spm12_dir);
    cat12_dir = fullfile(spm12_dir, 'toolbox', 'cat12');
    if ~exist(cat12_dir, 'dir')
        error('cat12bet:missingDep', 'CAT12 not found in: %s', cat12_dir);
    end
    addpath(cat12_dir);

    if ~exist('spm', 'file')
        error('cat12bet:missingDep', 'SPM12 is not on the MATLAB path.');
    end
    if ~exist('cat12', 'file')
        error('cat12bet:missingDep', 'CAT12 is not on the MATLAB path.');
    end

    spm('defaults', 'fmri');
    spm_jobman('initcfg');

    matlabbatch{1}.spm.tools.cat.estwrite.data = {t1w_src};
    matlabbatch{1}.spm.tools.cat.estwrite.nproc = nproc;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.gcutstr = 2;
    matlabbatch{1}.spm.tools.cat.estwrite.output.surface = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.GM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.bias.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.jacobianwarped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.warps = [0 0];

    spm_jobman('run', matlabbatch);

end
