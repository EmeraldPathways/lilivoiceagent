from google.adk.agents import Agent
from google.adk.tools import google_search

root_agent = Agent(
    name="ai_news_agent_search",
    model="gemini-2.5-flash-native-audio-preview-12-2025",
    instruction="you are an Ai News Assistant. Use Google Search to find recent Ai news",
    tools=[google_search]
)
