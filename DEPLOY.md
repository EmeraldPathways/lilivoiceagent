# 🚀 Deploy to Google Cloud Run

This guide walks you through deploying Lili Voice Agent to **Google Cloud Run**.

## 📋 Prerequisites

1. **Google Cloud SDK** (`gcloud`) installed → [Install Guide](https://cloud.google.com/sdk/docs/install)
2. **Google Cloud project** with billing enabled
3. **Google API Key** from [Google AI Studio](https://makersuite.google.com/app/apikey)

Your Project Details:
- **Project ID:** `gen-lang-client-0797203816`
- **Project Name:** LILI VOICE AGENT
- **Project Number:** 1032078340716

---

## ⚡ Quick Deploy (One Command)

```bash
# 1. Set your API key
export GOOGLE_API_KEY="your-google-api-key-here"

# 2. Authenticate with Google Cloud
gcloud auth login
gcloud config set project gen-lang-client-0797203816

# 3. Run the deploy script
chmod +x deploy.sh
./deploy.sh gen-lang-client-0797203816 us-central1
```

Your app will be live at: `https://lili-voice-agent-xxxxxxxxxx-uc.a.run.app`

---

## 📖 Step-by-Step Manual Deploy

### Step 1: Authenticate

```bash
gcloud auth login
gcloud config set project gen-lang-client-0797203816
```

### Step 2: Enable Required APIs

```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable secretmanager.googleapis.com
```

### Step 3: Store API Key in Secret Manager

```bash
# Create the secret
echo -n "your-google-api-key" | gcloud secrets create google-api-key \
    --data-file=- \
    --project=gen-lang-client-0797203816

# Verify it was created
gcloud secrets list
```

### Step 4: Build and Deploy

**Option A: Using Cloud Build (Recommended)**

```bash
export GOOGLE_API_KEY="your-api-key"

gcloud builds submit \
    --config=cloudbuild.yaml \
    --substitutions=_GOOGLE_API_KEY=$GOOGLE_API_KEY \
    --project=gen-lang-client-0797203816
```

**Option B: Manual Docker Build**

```bash
# Build the image
gcloud builds submit --tag gcr.io/gen-lang-client-0797203816/lili-voice-agent:latest

# Deploy to Cloud Run
gcloud run deploy lili-voice-agent \
    --image gcr.io/gen-lang-client-0797203816/lili-voice-agent:latest \
    --region us-central1 \
    --platform managed \
    --allow-unauthenticated \
    --set-secrets GOOGLE_API_KEY=google-api-key:latest \
    --memory 1Gi \
    --cpu 1
```

---

## 🔧 Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `GOOGLE_API_KEY` | Google API Key for Gemini access | Yes |
| `PORT` | Port to run the app (default: 7860) | No |

### Cloud Run Settings

| Setting | Value | Description |
|---------|-------|-------------|
| Memory | 1 GiB | Recommended for AI workloads |
| CPU | 1 | Standard allocation |
| Concurrency | 80 | Max requests per instance |
| Max Instances | 10 | Cost control |
| Timeout | 300s | Request timeout |

---

## 📁 Deployment Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Container definition |
| `cloudbuild.yaml` | Cloud Build CI/CD pipeline |
| `service.yaml` | Cloud Run service specification |
| `deploy.sh` | One-command deployment script |

---

## 🌐 Accessing Your App

After deployment, you'll get a URL like:
```
https://lili-voice-agent-abc123-uc.a.run.app
```

### View Logs
```bash
gcloud logging tail "resource.type=cloud_run_revision AND resource.labels.service_name=lili-voice-agent" --project=gen-lang-client-0797203816
```

### Update Deployment
```bash
# Make changes to code, then rebuild
gcloud builds submit --config=cloudbuild.yaml --project=gen-lang-client-0797203816
```

### Delete Service
```bash
gcloud run services delete lili-voice-agent --region=us-central1 --project=gen-lang-client-0797203816
```

---

## 💰 Cost Estimation

Cloud Run pricing (as of 2024):
- **Free Tier:** 2 million requests/month, 360,000 GB-seconds memory, 180,000 vCPU-seconds
- **Beyond Free:** ~$0.00002400/vCPU-second + $0.00000250/GB-second

For low-traffic personal use: **$0 - $5/month**

---

## 🛠️ Troubleshooting

### Build Fails
```bash
# Check build logs
gcloud builds list --project=gen-lang-client-0797203816
gcloud builds log [BUILD_ID]
```

### App Won't Start
```bash
# Check service logs
gcloud run services logs read lili-voice-agent --region=us-central1
```

### Secret Not Found
```bash
# Verify secret exists
gcloud secrets versions list google-api-key --project=gen-lang-client-0797203816

# Recreate if needed
echo -n "your-api-key" | gcloud secrets create google-api-key --data-file=- --project=gen-lang-client-0797203816
```

---

## 📚 Additional Resources

- [Google Cloud Run Docs](https://cloud.google.com/run/docs)
- [Cloud Build Docs](https://cloud.google.com/build/docs)
- [Secret Manager Docs](https://cloud.google.com/secret-manager/docs)
- [Gradio Deployment Guide](https://www.gradio.app/guides/deploying-gradio-apps)

---

**Ready to deploy?** Run the Quick Deploy command above! 🚀
