function cat12coreg(t1w_src, t1w_ref, spm12_dir)

    narginchk(3, 3);

    if ~ischar(t1w_src) || ~exist(t1w_src, 'file')
        error('cat12coreg:invalidInput', 'Source image not found: %s', t1w_src);
    end
    if ~ischar(t1w_ref) || ~exist(t1w_ref, 'file')
        error('cat12coreg:invalidInput', 'Reference image not found: %s', t1w_ref);
    end
    if ~ischar(spm12_dir) || ~exist(spm12_dir, 'dir')
        error('cat12coreg:invalidInput', 'SPM12 directory not found: %s', spm12_dir);
    end

    addpath(spm12_dir);
    cat12_dir = fullfile(spm12_dir, 'toolbox', 'cat12');
    if ~exist(cat12_dir, 'dir')
        error('cat12coreg:missingDep', 'CAT12 not found in: %s', cat12_dir);
    end
    addpath(cat12_dir);

    if ~exist('spm', 'file')
        error('cat12coreg:missingDep', 'SPM12 is not on the MATLAB path.');
    end

    spm('defaults', 'fmri');
    spm_jobman('initcfg');

    matlabbatch{1}.spm.spatial.coreg.estwrite.source = {t1w_src};
    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {t1w_ref};
    matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'coreg_';

    spm_jobman('run', matlabbatch);

end

