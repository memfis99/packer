

source "virtualbox-iso" "ubuntu" {
  guest_os_type     = "Ubuntu_64"
  //boot_order        = "disk,cdrom"
  cd_files          = ["./cloud-init/meta-data", "./cloud-init/user-data"]
  cd_label          = "cidata"
  iso_url           = "ubuntu-20.04.6-live-server-amd64.iso"
  iso_checksum      = "md5:5a4fcbde8b0585d78b3de3cb33bcd874"
  output_directory  = "output_ubuntu_tdhtest"
  shutdown_command  = "echo '131384' | sudo -S shutdown -P now"
  //shutdown_command  = "shutdown -P now"
  //disk_size         = "15000M"
  format            = "ova"
  http_directory    = "./ubuntu-temp"
  //headless          = true
  ssh_username      = "user"
  ssh_password      = "password"
  ssh_timeout       = "60m"
  ssh_port          = "22"
  vm_name           = "tdhtest3"
  disk_size         = 15000
  boot_wait         = "120s"
  vboxmanage = [
      ["modifyvm", "{{.Name}}", "--firmware", "EFI" ],
      ["modifyvm", "{{.Name}}", "--memory", "1024"],
      ["modifyvm", "{{.Name}}", "--cpus", "2"],

 ]
boot_command = [
    "yes<enter>"
//    "e<down><down><down><end>",
//    " autoinstall ds=nocloud;",
//    "<F10>"

//          "<esc><wait>",
//          "<esc><wait>",
//          "<enter><wait>",
//          "/install/vmlinuz<wait>",
//          " initrd=/install/initrd.gz",
//          " auto-install/enable=true",
//          " debconf/priority=critical",
//          " netcfg/get_domain=vm<wait>",
//          " netcfg/get_hostname=vagrant<wait>",
//          " grub-installer/bootdev=/dev/sda<wait>",
//          " preseed/url=http://:/preseed.cfg<wait>",
//          " -- <wait>",
//          "<enter><wait>"

//            "<enter><wait><f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
//            "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
//            "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
//            "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
//            "/install/vmlinuz<wait>",
//            " auto<wait>",
//            " console-setup/ask_detect=false<wait>",
//            " console-setup/layoutcode=us<wait>",
//            " console-setup/modelcode=pc105<wait>",
//            " debconf/frontend=noninteractive<wait>",
//            " debian-installer=en_US<wait>",
//            " fb=false<wait>",
//            " initrd=/install/initrd.gz<wait>",
//            " kbd-chooser/method=us<wait>",
//            " keyboard-configuration/layout=USA<wait>",
//            " keyboard-configuration/variant=USA<wait>",
//            " locale=en_US<wait>",
//            " netcfg/get_domain=local<wait>",
//            " netcfg/get_hostname=ubuntu<wait>",
//            " grub-installer/bootdev=/dev/sda<wait>",
//            " noapic<wait>",
//            " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
//            " -- <wait>",
//            "<enter><wait>",
//            "<tab><tab><tab><tab><tab><enter><wait>",

]
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]
  provisioner "shell" {
    // run scripts with sudo, as the default cloud image user is unprivileged
    execute_command = "echo '131384' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    // NOTE: cleanup.sh should always be run last, as this performs post-install cleanup tasks
    scripts = [
      "cloud-init/src/install.sh" ]
  }    
}

