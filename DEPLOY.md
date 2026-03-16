# 🚀 Deploy Lili Voice Agent to Google Cloud Run

Deploy Google ADK's **built-in web UI** to Google Cloud Run.

## 📋 Your Setup

| Setting | Value |
|---------|-------|
| **Project ID** | `gen-lang-client-0797203816` |
| **Secret Name** | `LiliVoiceAgent` (already created!) |
| **Region** | `us-central1` |
| **Web UI** | Google ADK's native web interface |

---

## ⚡ Quick Deploy (Run This Now)

```bash
# 1. Authenticate with Google Cloud
gcloud auth login
gcloud config set project gen-lang-client-0797203816

# 2. Run the deploy script
chmod +x deploy.sh
./deploy.sh
```

That's it! Your app will be live in ~3 minutes.

---

## 📖 What Gets Deployed

The **Google ADK native web UI** - the same interface you see when running `adk web` locally.

Features:
- 💬 Chat interface with your AI News Agent
- 🔍 Built-in conversation history
- ⚡ Real-time responses with Google Search
- 🎨 Clean, professional UI

---

## 🔧 Manual Deploy (If Script Fails)

### Step 1: Build

```bash
gcloud builds submit \
    --tag gcr.io/gen-lang-client-0797203816/lili-voice-agent:latest \
    --project=gen-lang-client-0797203816
```

### Step 2: Deploy

```bash
gcloud run deploy lili-voice-agent \
    --image gcr.io/gen-lang-client-0797203816/lili-voice-agent:latest \
    --region us-central1 \
    --platform managed \
    --allow-unauthenticated \
    --set-secrets GOOGLE_API_KEY=LiliVoiceAgent:latest \
    --memory 2Gi \
    --cpu 1 \
    --max-instances 5
```

---

## ✅ Verify Your Secret

Your secret `LiliVoiceAgent` should contain your Google API key.

Verify it exists:
```bash
gcloud secrets describe LiliVoiceAgent --project=gen-lang-client-0797203816
```

View the value (to confirm it's correct):
```bash
gcloud secrets versions access latest --secret=LiliVoiceAgent --project=gen-lang-client-0797203816
```

---

## 🌐 Access Your App

After deployment, open the URL shown in the console. It looks like:
```
https://lili-voice-agent-xxxxx-uc.a.run.app
```

You'll see the **Google ADK Web UI** with your AI News Agent ready to chat!

---

## 🛠️ Troubleshooting

| Issue | Fix |
|-------|-----|
| Build fails | Check `gcloud builds list --project=gen-lang-client-0797203816` |
| App won't start | Check logs: `gcloud run logs read lili-voice-agent --region=us-central1` |
| Secret not found | Verify: `gcloud secrets list --project=gen-lang-client-0797203816` |
| Permission denied | Run `gcloud auth login` again |

---

**Ready?** Run the Quick Deploy command above! 🚀
