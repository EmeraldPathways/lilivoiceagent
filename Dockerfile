# Lili Voice Agent - Docker Container
# Deploy to Google Cloud Run

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .
COPY ai_news_agent_search/ ./ai_news_agent_search/

# Create non-root user for security
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose port (Gradio default)
EXPOSE 7860

# Environment variable for Google Cloud Run
ENV PORT=7860

# Run the application
CMD python app.py
