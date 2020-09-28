resource "google_compute_shared_vpc_host_project" "host" {
  project = data.terraform_remote_state.projects.network.project_id
}

resource "google_compute_shared_vpc_service_project" "service-a" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = data.terraform_remote_state.projects.service-a.project_id
}
