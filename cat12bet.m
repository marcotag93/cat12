function cat12bet(t1w_src, spm12_dir)

    addpath(spm12_dir);
    addpath(fullfile(spm12_dir, 'toolbox', 'cat12'));

    matlabbatch{1}.spm.tools.cat.estwrite.data = {t1w_src};
    matlabbatch{1}.spm.tools.cat.estwrite.nproc = 6;
    matlabbatch{1}.spm.tools.cat.estwrite.extopts.gcutstr = 2;
    matlabbatch{1}.spm.tools.cat.estwrite.output.surface = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.GM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WM.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.CSF.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.WMH.native = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.bias.warped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.jacobianwarped = 0;
    matlabbatch{1}.spm.tools.cat.estwrite.output.warps = [0 0];

    spm_jobman('run', matlabbatch); % > to run it
    % spm_jobman('interactive', matlabbatch); % > to open the batch

end
