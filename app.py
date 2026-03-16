"""
Lili Voice Agent - Google ADK Web Interface
For deployment to Google Cloud Run with ADK's built-in web UI
"""

import os
import subprocess
import sys

if __name__ == "__main__":
    # Get port from environment variable (Cloud Run sets PORT env var)
    port = os.environ.get("PORT", "8080")
    
    # Set environment variables for ADK web
    os.environ["ADK_WEB_PORT"] = str(port)
    os.environ["ADK_WEB_HOST"] = "0.0.0.0"
    
    print(f"🚀 Starting Lili Voice Agent on port {port}")
    print(f"🌐 Access the web UI at your Cloud Run URL")
    
    # Run ADK web using subprocess
    # This properly serves the ADK web interface
    cmd = [
        sys.executable, "-m", "google.adk.cli",
        "web",
        "--port", str(port),
        "--host", "0.0.0.0"
    ]
    
    # Execute the ADK web server
    subprocess.run(cmd, cwd="/app")
