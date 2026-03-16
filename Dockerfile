# Lili Voice Agent - Google ADK Web UI
# Deploy to Google Cloud Run

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
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

# Expose port (Cloud Run default)
EXPOSE 8080

# Environment variable for Google Cloud Run
ENV PORT=8080

# Run the ADK web interface
CMD ["python", "app.py"]
