# mi-qutic-pdns

use [joyent/mibe](https://github.com/joyent/mibe) to create a provisionable image

## installation

The following sample can be used to create a zone running a copy of the the worker image.

```
IMAGE_UUID=$(imgadm list | grep 'qutic-pdns' | tail -1 | awk '{ print $1 }')
vmadm create << EOF
{
  "brand":      "joyent",
  "image_uuid": "$IMAGE_UUID",
  "alias":      "pdns-server",
  "hostname":   "pdns.example.com",
  "dns_domain": "example.com",
  "resolvers": [
    "80.80.80.80",
    "80.80.81.81"
  ],
  "nics": [
    {
      "interface": "net0",
      "nic_tag":   "admin",
      "ip":        "10.10.10.10",
      "gateway":   "10.10.10.1",
      "netmask":   "255.255.255.0",
      "primary":   true
    }
  ],
  "max_physical_memory": 512,
  "max_swap":            512,
  "quota":                10,
  "cpu_cap":             100,
  "customer_metadata": {
    "admin_authorized_keys": "your-long-key",
    "root_authorized_keys":  "your-long-key",
    "mail_smarthost":        "mail.example.com",
    "mail_auth_user":        "you@example.com",
    "mail_auth_pass":        "smtp-account-password",
    "mail_adminaddr":        "report@example.com",
    "munin_master_allow":    "munin-master-ip"
  }
}
EOF
```

## Notes

* on update to 4.1.1 we nood to run: "ALTER TABLE domains MODIFY notified_serial INT UNSIGNED DEFAULT NULL;"
* Recursion was removed from the Authoritative Server in version 4.1.0: https://doc.powerdns.com/authoritative/guides/recursion.html
