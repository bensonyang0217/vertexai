# 配置 Google Cloud 提供者
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# 定義 Cloud Run 服務
resourcce "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/your-project-id/your-image:tag"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# 設置 IAM 策略以允許所有用戶訪問該服務
resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# 輸出 Cloud Run 服務 URL
output "service_url" {
  value = google_cloud_run_service.default.status[0].url
}