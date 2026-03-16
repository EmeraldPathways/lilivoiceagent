"""
Lili Voice Agent - Gradio Interface
An AI News Assistant powered by Google ADK and Gemini
"""

import os
import gradio as gr
from google.adk.agents import Agent
from google.adk.tools import google_search
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize the agent
root_agent = Agent(
    name="ai_news_agent_search",
    model="gemini-2.0-flash-exp",
    instruction="""You are an AI News Assistant. Your goal is to help users stay updated with the latest AI news.

When users ask about AI news:
1. Use Google Search to find recent and relevant AI news
2. Summarize the key information in a clear, concise manner
3. Provide context and insights when appropriate
4. If the user asks about specific topics, focus your search on those areas

Always be helpful, informative, and engaging in your responses.""",
    tools=[google_search]
)

# Initialize session service and runner
session_service = InMemorySessionService()
runner = Runner(
    agent=root_agent,
    app_name="lili_voice_agent",
    session_service=session_service
)

# Create a session
session = session_service.create_session(app_name="lili_voice_agent", user_id="user")


async def chat_with_agent(message, history):
    """Process user message and return agent response."""
    try:
        # Run the agent
        content = {"parts": [{"text": message}]}
        
        final_response = ""
        async for event in runner.run_async(
            session_id=session.id,
            user_id="user",
            new_message=content
        ):
            if event.is_final_response():
                if event.content and event.content.parts:
                    final_response = event.content.parts[0].text
                break
        
        return final_response if final_response else "I couldn't find any relevant information. Please try asking differently."
    
    except Exception as e:
        return f"Error: {str(e)}. Please make sure your GOOGLE_API_KEY is set correctly."


def clear_history():
    """Clear the conversation history."""
    global session
    session = session_service.create_session(app_name="lili_voice_agent", user_id="user")
    return None


# Custom CSS for a polished look
custom_css = """
.gradio-container {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
}
.chatbot {
    border-radius: 16px !important;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08) !important;
}
.input-container {
    border-radius: 12px !important;
}
.title {
    text-align: center;
    margin-bottom: 1rem;
}
.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 2rem;
}
"""

# Create the Gradio interface
with gr.Blocks(css=custom_css, theme=gr.themes.Soft()) as demo:
    gr.HTML("""
        <div class="title">
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                🤖 Lili Voice Agent
            </h1>
        </div>
        <div class="subtitle">
            <p>Your AI News Assistant powered by Gemini & Google Search</p>
        </div>
    """)
    
    chatbot = gr.Chatbot(
        height=500,
        bubble_full_width=False,
        show_copy_button=True,
        avatar_images=(None, "🤖"),
        type="messages"
    )
    
    with gr.Row():
        msg = gr.Textbox(
            show_label=False,
            placeholder="Ask me about the latest AI news...",
            scale=10,
            container=False
        )
        submit_btn = gr.Button("Send", scale=1, variant="primary")
    
    with gr.Row():
        clear_btn = gr.Button("🗑️ Clear Conversation", variant="secondary")
        gr.HTML("""
            <div style="text-align: right; flex: 1;">
                <a href="https://github.com/EmeraldPathways/lilivoiceagent" target="_blank" style="text-decoration: none; color: #667eea;">
                    📁 View on GitHub
                </a>
            </div>
        """)
    
    # Examples
    gr.Examples(
        examples=[
            "What's the latest news in AI today?",
            "Tell me about recent breakthroughs in large language models",
            "What are the newest AI tools released this week?",
            "Any news about AI regulation?",
            "What's happening with Gemini and OpenAI?"
        ],
        inputs=msg,
        label="💡 Try these examples"
    )
    
    # Event handlers
    submit_btn.click(chat_with_agent, [msg, chatbot], chatbot).then(
        lambda: "", None, msg
    )
    msg.submit(chat_with_agent, [msg, chatbot], chatbot).then(
        lambda: "", None, msg
    )
    clear_btn.click(clear_history, None, chatbot)

if __name__ == "__main__":
    demo.launch()
