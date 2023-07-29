#!/bin/sh
CMD="packer build -timestamp-ui -parallel-builds=1 -force ubuntu-vbox2.pkr.hcl"
echo $CMD
$CMD
