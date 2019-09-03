# initramfs-tools-pi4

## Setup
```sh
git init --bare /etc/initramfs-tools/.gitinitram
alias gitinitram='git --git-dir=/etc/initramfs-tools/.gitinitram/ --work-tree=/etc/initramfs-tools'
echo "alias gitinitram='git --git-dir=/etc/initramfs-tools/.gitinitram/ --work-tree=/etc/initramfs-tools'" >> /root/.bashrc
gitinitram config --local status.showUntrackedFiles no
gitinitram remote add origin https://github.com/USERNAME/GITREPO.git
```

## Replication
(relies on rsync to deal with conflicts i.e. if newer on git then will replace local copy):
```sh
git clone --separate-git-dir=/etc/initramfs-tools/.gitinitram https://github.com/USERNAME/GITREPO.git gitinitram-tmp
rsync --update --archive --verbose --exclude '.git' gitinitram-tmp/ /etc/initramfs-tools/
rm --recursive gitinitram-tmp
```


## Usage
```sh
gitinitram status
gitinitram add .gitconfig
gitinitram commit -m 'Add gitconfig'
gitinitram push
```
