function cat12coreg(t1w_src, t1w_ref, spm12_dir)

    addpath(spm12_dir);
    addpath(fullfile(spm12_dir, 'toolbox', 'cat12'));

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

    spm_jobman('run', matlabbatch); % > to run it
    % spm_jobman('interactive', matlabbatch); % > to open the batch

end

