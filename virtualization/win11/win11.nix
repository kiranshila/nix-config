{inputs, ...}: {
  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.connections."qemu:///system".domains = [
    {
      definition = inputs.nixvirt.lib.domain.writeXML (
        inputs.nixvirt.lib.domain.templates.windows {
          name = "Windows 11";
          uuid = "3f13d036-69a7-4594-83f0-a3d511de7417";
          memory = {
            count = 32;
            unit = "GiB";
          };
          storage_vol = /mnt/hdd/win11/win11.qcow2;
          nvram_path = /mnt/hdd/win11/win11.nvram;
          virtio_net = true;
          virtio_drive = true;
        }
      );
    }
  ];
}
