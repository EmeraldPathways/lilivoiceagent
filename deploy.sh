#!/bin/bash
# Deploy Lili Voice Agent to Google Cloud Run
# Uses Google ADK's built-in web UI

set -e

# Configuration
PROJECT_ID="gen-lang-client-0797203816"
REGION="us-central1"
SERVICE_NAME="lili-voice-agent"
SECRET_NAME="LiliVoiceAgent"

echo "🚀 Deploying Lili Voice Agent to Google Cloud Run"
echo "================================================"
echo "Project ID: $PROJECT_ID"
echo "Region: $REGION"
echo "Service: $SERVICE_NAME"
echo "Secret: $SECRET_NAME"
echo ""

# Check if gcloud is authenticated
echo "🔐 Checking Google Cloud authentication..."
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q "@"; then
    echo "❌ Not authenticated. Running gcloud auth login..."
    gcloud auth login
fi

# Set project
gcloud config set project $PROJECT_ID
echo "✅ Project set to $PROJECT_ID"
echo ""

# Enable required APIs
echo "📦 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com --project=$PROJECT_ID
gcloud services enable run.googleapis.com --project=$PROJECT_ID
gcloud services enable secretmanager.googleapis.com --project=$PROJECT_ID
echo "✅ APIs enabled"
echo ""

# Verify secret exists
echo "🔐 Verifying secret '$SECRET_NAME' exists..."
if ! gcloud secrets describe $SECRET_NAME --project=$PROJECT_ID &>/dev/null; then
    echo "❌ Error: Secret '$SECRET_NAME' not found in Secret Manager"
    echo "Please create it first:"
    echo "  echo -n 'your-api-key' | gcloud secrets create $SECRET_NAME --data-file=- --project=$PROJECT_ID"
    exit 1
fi
echo "✅ Secret verified"
echo ""

# Build and deploy
echo "🔨 Building and deploying..."
gcloud builds submit \
    --config=cloudbuild.yaml \
    --project=$PROJECT_ID \
    --quiet

echo ""
echo "✅ Build complete!"
echo ""

# Get service URL
echo "🌐 Getting service URL..."
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME \
    --region=$REGION \
    --project=$PROJECT_ID \
    --format='value(status.url)' 2>/dev/null || echo "")

if [ -n "$SERVICE_URL" ]; then
    echo ""
    echo "================================================"
    echo "🎉 Deployment Successful!"
    echo "================================================"
    echo ""
    echo "Your ADK Web UI is live at:"
    echo "$SERVICE_URL"
    echo ""
    echo "Open this URL in your browser to use the agent!"
    echo ""
    echo "To view logs:"
    echo "  gcloud logging tail \"resource.type=cloud_run_revision AND resource.labels.service_name=$SERVICE_NAME\" --project=$PROJECT_ID"
    echo ""
else
    echo "⚠️  Could not retrieve service URL. Check deployment status:"
    echo "  gcloud run services describe $SERVICE_NAME --region=$REGION --project=$PROJECT_ID"
fi
