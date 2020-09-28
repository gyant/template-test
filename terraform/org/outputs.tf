output "org" {
  value = data.google_organization
}

output "folders" {
  value = {
    services = google_folder.services
    shared   = google_folder.shared
  }
}

output "projects" {
  value = {
    network   = google_project.network
    service-a = google_project.service-a
  }
}
