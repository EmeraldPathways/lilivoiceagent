#!/bin/bash
# Deploy Lili Voice Agent to Google Cloud Run
# Usage: ./deploy.sh [PROJECT_ID] [REGION]

set -e

# Configuration
PROJECT_ID=${1:-$(gcloud config get-value project)}
REGION=${2:-us-central1}
SERVICE_NAME="lili-voice-agent"

echo "🚀 Deploying Lili Voice Agent to Google Cloud Run"
echo "================================================"
echo "Project ID: $PROJECT_ID"
echo "Region: $REGION"
echo "Service: $SERVICE_NAME"
echo ""

# Check if GOOGLE_API_KEY is set
if [ -z "$GOOGLE_API_KEY" ]; then
    echo "❌ Error: GOOGLE_API_KEY environment variable is not set"
    echo "Please set it first: export GOOGLE_API_KEY='your-api-key'"
    exit 1
fi

# Check if project is set
if [ -z "$PROJECT_ID" ] || [ "$PROJECT_ID" = "(unset)" ]; then
    echo "❌ Error: No Google Cloud project configured"
    echo "Please set it: gcloud config set project YOUR_PROJECT_ID"
    exit 1
fi

echo "✅ Configuration valid"
echo ""

# Enable required APIs
echo "📦 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com --project=$PROJECT_ID
gcloud services enable run.googleapis.com --project=$PROJECT_ID
gcloud services enable secretmanager.googleapis.com --project=$PROJECT_ID
echo "✅ APIs enabled"
echo ""

# Store API key in Secret Manager (if not exists)
echo "🔐 Setting up Secret Manager for API key..."
if ! gcloud secrets describe google-api-key --project=$PROJECT_ID &>/dev/null; then
    echo "Creating secret for GOOGLE_API_KEY..."
    echo -n "$GOOGLE_API_KEY" | gcloud secrets create google-api-key \
        --data-file=- \
        --project=$PROJECT_ID
else
    echo "Secret already exists, updating..."
    echo -n "$GOOGLE_API_KEY" | gcloud secrets versions add google-api-key \
        --data-file=- \
        --project=$PROJECT_ID
fi
echo "✅ Secret configured"
echo ""

# Build and deploy using Cloud Build
echo "🔨 Building and deploying container..."
gcloud builds submit \
    --config=cloudbuild.yaml \
    --substitutions=_GOOGLE_API_KEY=$GOOGLE_API_KEY \
    --project=$PROJECT_ID \
    --quiet
echo "✅ Build complete"
echo ""

# Get the service URL
echo "🌐 Getting service URL..."
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME \
    --region=$REGION \
    --project=$PROJECT_ID \
    --format='value(status.url)')

echo ""
echo "================================================"
echo "🎉 Deployment Successful!"
echo "================================================"
echo ""
echo "Your app is live at:"
echo "$SERVICE_URL"
echo ""
echo "To view logs:"
echo "gcloud logging tail \"resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME\" --project=$PROJECT_ID"
echo ""
