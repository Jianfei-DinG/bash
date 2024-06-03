
bios 中开启VT-d   可以看见可以直通的设备

直通教程
https://www.youtube.com/watch?v=jiBxVuDMZbY&t=327s

hypervisor.cpuid.v0=FALSE #添加后windows cpu 显示虚拟化：不可用

ESXI安装
```
Shift+O 编辑引导选项

systemMediaSize=min   #这个是修改整个ESXi 占用空间大小 最小为32G (官方推荐）
min：32 GB
small:64  GB
default:128  GB
max:ALL

autoPartitionOSDataSize=4096  指定调整ESX-OSData大小
```
兼容老款CPU
```
allowLegacyCPU=true  #兼容老款CPU
```

文档
https://docs.vmware.com/cn/VMware-vSphere/7.0/com.vmware.esxi.upgrade.doc/GUID-9040F0B2-31B5-406C-9000-B02E8DA785D4.html
