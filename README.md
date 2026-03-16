# 🤖 Lili Voice Agent

An intelligent AI News Assistant powered by Google's Agent Development Kit (ADK) and Gemini. Stay updated with the latest AI news through natural conversation.

[![Hugging Face Spaces](https://img.shields.io/badge/🤗%20Hugging%20Face-Spaces-yellow?style=flat-square)](https://huggingface.co/spaces/YOUR_USERNAME/lili-voice-agent)
[![GitHub](https://img.shields.io/badge/GitHub-View%20Repo-blue?style=flat-square&logo=github)](https://github.com/EmeraldPathways/lilivoiceagent)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Landing%20Page-green?style=flat-square&logo=github)](https://emeraldpathways.github.io/lilivoiceagent/)

![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat-square&logo=python&logoColor=white)
![Google ADK](https://img.shields.io/badge/Google%20ADK-Latest-4285F4?style=flat-square&logo=google)
![Gemini](https://img.shields.io/badge/Gemini-2.0%20Flash-8E75B2?style=flat-square&logo=googlegemini)
![Gradio](https://img.shields.io/badge/Gradio-4.0+-FF6B6B?style=flat-square)

---

## 🚀 Live Demo

Try the live demo on Hugging Face Spaces: **Coming Soon** 🎉

Or run locally:

```bash
# Clone the repository
git clone https://github.com/EmeraldPathways/lilivoiceagent.git
cd lilivoiceagent

# Set up environment
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set your Google API key
export GOOGLE_API_KEY="your-api-key"  # Windows: set GOOGLE_API_KEY=your-api-key

# Run the Gradio app
python app.py
```

---

## ✨ Features

- 📰 **Latest AI News** - Get real-time AI news updates powered by Google Search
- 💬 **Natural Conversations** - Chat naturally with Gemini-powered conversational AI
- 🔎 **Web Search** - Intelligent search capabilities to find relevant AI news articles
- ⚡ **Fast & Efficient** - Built with Google's ADK for optimal performance
- 🎨 **Beautiful UI** - Polished Gradio interface with responsive design

---

## 🛠️ How It Works

1. **Ask a Question** - Ask about the latest AI news, trends, or specific topics
2. **Smart Search** - The agent uses Google Search to find relevant information
3. **Get Answers** - Gemini processes the results and provides a clear response

---

## 📁 Project Structure

```
lilivoiceagent/
├── ai_news_agent_search/    # ADK Agent module
│   ├── __init__.py
│   └── agent.py
├── app.py                   # Gradio web interface
├── requirements.txt         # Python dependencies
├── .env                     # Environment variables (not tracked)
├── .gitignore              # Git ignore rules
├── index.html              # GitHub Pages landing page
└── README.md               # This file
```

---

## 🔧 Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `GOOGLE_API_KEY` | Your Google API key with Gemini access | Yes |

Get your API key from: [Google AI Studio](https://makersuite.google.com/app/apikey)

---

## 🚀 Deploy to Hugging Face Spaces

### Option 1: One-click Deploy (Recommended)

1. Go to [Hugging Face Spaces](https://huggingface.co/spaces)
2. Click "Create new Space"
3. Select "Gradio" as the Space SDK
4. Choose a name (e.g., `lili-voice-agent`)
5. Set visibility (Public or Private)
6. In Space Settings → Variables and Secrets, add:
   - Name: `GOOGLE_API_KEY`
   - Value: Your Google API key
7. Clone the space locally and push this repo's files

### Option 2: Using Git

```bash
# Install Hugging Face CLI
pip install huggingface-hub

# Login
huggingface-cli login

# Create space (replace USERNAME with your HF username)
huggingface-cli repo create lili-voice-agent --type space --sdk gradio

# Clone the space
git clone https://huggingface.co/spaces/USERNAME/lili-voice-agent
cd lili-voice-agent

# Copy files from this repo
cp ../lilivoiceagent/app.py .
cp ../lilivoiceagent/requirements.txt .
cp -r ../lilivoiceagent/ai_news_agent_search .

# Commit and push
git add .
git commit -m "Initial commit"
git push
```

---

## 📝 Example Conversations

> **User:** What's the latest news in AI today?
> 
> **Lili:** Let me search for the latest AI news for you...

> **User:** Tell me about recent breakthroughs in large language models
> 
> **Lili:** Here are the most recent developments in LLMs...

> **User:** Any news about AI regulation?
> 
> **Lili:** I'll find the latest updates on AI regulation for you...

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙏 Acknowledgments

- [Google ADK](https://github.com/google/adk) - Agent Development Kit
- [Gemini](https://gemini.google.com) - Google's AI model
- [Gradio](https://gradio.app) - Python web UI framework
- [Hugging Face Spaces](https://huggingface.co/spaces) - ML app hosting

---

<p align="center">
  Made with 💜 by <a href="https://github.com/EmeraldPathways">EmeraldPathways</a>
</p>
