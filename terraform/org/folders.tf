resource "google_folder" "services" {
  display_name = "Services"
  parent       = data.google_organization.org.org_id
}

resource "google_folder" "shared" {
  display_name = "Shared"
  parent       = data.google_organization.org.org_id
}
