resource "google_organization_policy" "serial_port_policy" {
  org_id     = data.google_organization.org.org_id
  constraint = "compute.disableSerialPortAccess"

  boolean_policy {
    enforced = true
  }
}
