#!/bin/bash
############################
# This script creates symlinks from the home directory to every file in ./dotfiles while keeping old backups in ./dotfiles_backup
############################

# diff -r /media/ntfsdrive/data /media/ext4drive/data

timestamp=`date +%s`
mkdir -p ./backup

dir=`realpath ./dotfiles`                    # dotfiles directory
bkp_dir=`realpath ./backup`             # old dotfiles backup directory
bkp_dotfiles="${bkp_dir}/dotfiles"
mkdir -p "${bkp_dotfiles}"

file_list=`ls ${dir}`
for fname in $file_list; do
    if [ -f ~/.${fname} ]; then
        # Check if backup file already exists, and "logrotate" it, if it has a different content than the new dotfile
        if [ -f ${bkp_dotfiles}/${fname} ]; then
            # backup is the same as new version
            if cmp "${dir}/${fname}" "${bkp_dotfiles}/${fname}"; then
                continue
            fi
            rm -f ${bkp_dotfiles}/${fname}
        fi

        cp -L ~/.${fname} ${bkp_dotfiles}/${fname}_${timestamp} && ln -s ${bkp_dotfiles}/${fname}_${timestamp} ${bkp_dotfiles}/${fname} && rm ~/.${fname}
    fi

    ln -s ${dir}/${fname} ~/.${fname}
done


# Bash completion
dir=`realpath ./bash_completion.d`
mkdir -p ~/.bash_completion.d
bkp_completion="${bkp_dir}/bash_completion"
mkdir -p "${bkp_completion}"

file_list=`ls ${dir}`
for fname in $file_list; do
    if [ -f ~/.bash_completion.d/${fname} ]; then
        # Check if backup file already exists, and "logrotate" it, if it has a different content than the new dotfile
        if [ -f ${bkp_completion}/${fname} ]; then
            # backup is the same as new version
            if cmp "${dir}/${fname}" "${bkp_completion}/${fname}"; then
                continue
            fi
            rm -f ${bkp_completion}/${fname}
        fi

        cp -L ~/.bash_completion.d/${fname} ${bkp_completion}/${fname}_${timestamp} && ln -s ${bkp_completion}/${fname}_${timestamp} ${bkp_completion}/${fname} && rm ~/.bash_completion.d/${fname}
    fi
    ln -s ${dir}/${fname} ~/.bash_completion.d/${fname}
done

# .config
dir=`realpath ./config`
bkp_config="${bkp_dir}/config"
mkdir -p "${bkp_config}"

dir_list=`ls ${dir}`
for dirname in ${dir_list}; do
    if [ ! -d ${dir}/${dirname} ]; then
        echo "Skipping ${dir}/${dirname} - this code only works for directories"
        continue
    fi

    if [ -e ~/.config/${dirname} ]; then
        if [ -e ${dir}/${dirname} ]; then
            if [ ~/.config/${dirname} -ef ${dir}/${dirname} ]; then
                continue
            fi
            rm -f ${bkp_config}/${dirname}
        fi

        cp -RL ~/.config/${dirname} ${bkp_config}/${dirname}_${timestamp} && ln -s ${bkp_config}/${dirname}_${timestamp} ${bkp_config}/${dirname} && rm -rI ~/.config/${dirname}
    fi
    ln -s ${dir}/${dirname} ~/.config/${dirname}
done
