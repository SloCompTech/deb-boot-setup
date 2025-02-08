# Bootsetup

## Lock bootsetup

Once device is configured, bootsetup can be pretty dangerous thing, because now someone can change password of any user without any kind of authorization, can they ? The answer is **yes**. So what can you do ?

Solution is pretty simple:

- Create `lock` file and `lock-docker` in *bootsetup* folder (or `/etc/bootsetup/lock` if you want immediate effect), which will **lock down** *boot setup* system on next boot.
- If you still want to be able to configure Wi-Fi (and use other scripts-config scripts) create `lock-init` file instead of `lock` file.
