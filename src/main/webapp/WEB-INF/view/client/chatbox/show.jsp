<%@page contentType="text/html" pageEncoding="UTF-8" %>

<style>
	/* Modern Chatbox CSS */

/* Nút mở chat */
#chatbox-toggle {
    position: fixed;
    right: 24px;
    bottom: 24px;
    z-index: 2000;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

#chatbox-toggle:hover {
    transform: scale(1.05) translateY(-2px);
    box-shadow: 0 6px 20px rgba(16, 185, 129, 0.6);
}

/* Panel chat */
#chatbox-panel {
    position: fixed;
    right: 24px;
    bottom: 100px;
    width: 380px;
    height: 600px;
    max-width: calc(100% - 48px);
    max-height: calc(100vh - 120px);
    background: #ffffff;
    border-radius: 20px;
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    z-index: 2000;
    transform: translateY(20px) scale(0.95);
    opacity: 0;
    pointer-events: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

#chatbox-panel.active {
    transform: translateY(0) scale(1);
    opacity: 1;
    pointer-events: auto;
}

/* Header */
.chatbox-header {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.chatbox-header-info {
    display: flex;
    align-items: center;
    gap: 12px;
}

.chatbox-header-avatar {
    width: 40px;
    height: 40px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    backdrop-filter: blur(4px);
}

.chatbox-header strong {
    font-size: 1rem;
    font-weight: 600;
    display: block;
    letter-spacing: 0.3px;
}

.chatbox-header small {
    font-size: 0.75rem;
    opacity: 0.9;
    display: block;
    margin-top: 2px;
}

#chatbox-close {
    background: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
}

#chatbox-close:hover {
    background: rgba(255, 255, 255, 0.25);
}

/* Body */
.chatbox-body {
    padding: 20px;
    flex: 1;
    overflow-y: auto;
    background: #ffffff;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* Scrollbar */
.chatbox-body::-webkit-scrollbar {
    width: 5px;
}

.chatbox-body::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}

.chatbox-body::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}

/* Message wrapper */
.chat-message {
    display: flex;
    align-items: flex-end;
    gap: 8px;
    max-width: 85%;
    animation: slideIn 0.3s ease;
	background: white;
}

.chat-message.bot {
    align-self: flex-start;
}

.chat-message.user {
    align-self: flex-end;
    flex-direction: row-reverse;
}

@keyframes slideIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Avatar */
.message-avatar {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    flex-shrink: 0;
    background: white;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.chat-message.user .message-avatar {
    display: none; /* Hide user avatar for cleaner look */
}

/* Message content */
.message-content {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.message-sender {
    font-size: 0.7rem;
    color: #6b7280;
    margin-left: 4px;
    display: none; /* Hide sender name for cleaner look */
}

.bubble {
    padding: 10px 14px;
    border-radius: 18px;
    font-size: 0.95rem;
    line-height: 1.5;
    position: relative;
    word-wrap: break-word;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

/* Bot Bubble Style */
.chat-message.bot .bubble {
    background: white;
    color: #1f2937;
    border-bottom-left-radius: 4px;
	border: 1px solid #e5e7eb;
}

/* User Bubble Style */
.chat-message.user .bubble {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    border-bottom-right-radius: 4px;
}

/* Typing indicator */
.typing-indicator {
    display: flex;
    gap: 4px;
    padding: 12px 16px;
    background: white;
    border-radius: 18px;
    border-bottom-left-radius: 4px;
    width: fit-content;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.typing-indicator span {
    width: 6px;
    height: 6px;
    background: #9ca3af;
    border-radius: 50%;
    animation: typing 1.4s infinite ease-in-out;
}

.typing-indicator span:nth-child(1) { animation-delay: 0s; }
.typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
    0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
    30% { transform: translateY(-6px); opacity: 1; }
}

/* Footer */
.chatbox-footer {
    display: flex;
    gap: 10px;
    padding: 16px;
    background: white;
    border-top: 1px solid #e5e7eb;
}

.chatbox-footer input {
    flex: 1;
    padding: 10px 16px;
    border-radius: 24px;
    border: 1px solid #e5e7eb;
    font-size: 0.95rem;
    outline: none;
    transition: all 0.2s;
    background: #f3f4f6;
    color: #1f2937;
}

.chatbox-footer input:focus {
    border-color: #10b981;
    background: white;
    box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
}

.chatbox-footer button {
    padding: 0 20px;
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
    border: none;
    border-radius: 24px;
    cursor: pointer;
    transition: all 0.2s;
    font-weight: 600;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

.chatbox-footer button:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

.chatbox-footer button:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

/* Mobile */
@media (max-width: 480px) {
    #chatbox-panel {
        right: 0;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 100%;
        max-width: 100%;
        max-height: 100%;
        border-radius: 0;
        transform: translateY(100%);
    }
    
    #chatbox-panel.active {
        transform: translateY(0);
    }

    .chatbox-header {
        padding-top: env(safe-area-inset-top, 20px);
    }
    
    .chat-message { max-width: 90%; }
}
</style>

<!-- Nút mở chat -->
<button id="chatbox-toggle">💬</button>

<!-- Panel chat -->
<div id="chatbox-panel">
	<div class="chatbox-header">
		<div class="chatbox-header-info">
			<div class="chatbox-header-avatar">🤖</div>
			<div>
				<strong>LaptopShop Bot</strong>
				<small>Trực tuyến</small>
			</div>
		</div>
		<button id="chatbox-close">&times;</button>
	</div>

	<div class="chatbox-body" id="chatbox-body">
		<!-- Messages sẽ được append vào đây -->
	</div>

	<form class="chatbox-footer" id="chatbox-form">
		<input id="chatbox-input" placeholder="Nhập tin nhắn..." autocomplete="off" />
		<button type="submit" id="chatbox-send-btn">Gửi</button>
	</form>
</div>

<script>
(function () {
    const panel = document.getElementById('chatbox-panel');
    const toggle = document.getElementById('chatbox-toggle');
    const closeBtn = document.getElementById('chatbox-close');
    const body = document.getElementById('chatbox-body');
    const form = document.getElementById('chatbox-form');
    const input = document.getElementById('chatbox-input');
    const sendBtn = document.getElementById('chatbox-send-btn');

    const API_URL = window.CHATBOX_API_URL || 'http://localhost:8081/api/chat';

    const SESSION_ID = Date.now().toString();

    let isProcessing = false;
    let hasGreeted = false;

    /**
     * Append message với avatar và tên
     */
    function appendMessage(text, sender = "bot") {
        const messageWrap = document.createElement("div");
        messageWrap.className = `chat-message ${sender}`;

        // Avatar
        const avatar = document.createElement("div");
        avatar.className = "message-avatar";
        avatar.textContent = sender === 'user' ? '👤' : '🤖';

        // Content wrapper
        const contentWrap = document.createElement("div");
        contentWrap.className = "message-content";

        // Tên người gửi
        const senderName = document.createElement("div");
        senderName.className = "message-sender";
        senderName.textContent = sender === 'user' ? 'Bạn' : 'Bot LaptopShop';

        // Bubble
        const bubble = document.createElement("div");
        bubble.className = "bubble";
        bubble.textContent = text;

        // Assemble
        contentWrap.appendChild(senderName);
        contentWrap.appendChild(bubble);
        messageWrap.appendChild(avatar);
        messageWrap.appendChild(contentWrap);
        body.appendChild(messageWrap);

        smoothScrollToBottom();

        return messageWrap;
    }

    function showTypingIndicator() {
        const messageWrap = document.createElement("div");
        messageWrap.className = "chat-message bot";
        messageWrap.id = "typing-indicator";

        const avatar = document.createElement("div");
        avatar.className = "message-avatar";
        avatar.textContent = '🤖';

        const contentWrap = document.createElement("div");
        contentWrap.className = "message-content";

        const indicator = document.createElement("div");
        indicator.className = "typing-indicator";
        indicator.innerHTML = '<span></span><span></span><span></span>';

        contentWrap.appendChild(indicator);
        messageWrap.appendChild(avatar);
        messageWrap.appendChild(contentWrap);
        body.appendChild(messageWrap);

        smoothScrollToBottom();

        return messageWrap;
    }

    function removeTypingIndicator() {
        const indicator = document.getElementById("typing-indicator");
        if (indicator) indicator.remove();
    }

    function smoothScrollToBottom() {
        setTimeout(() => {
            body.scrollTo({ 
                top: body.scrollHeight, 
                behavior: "smooth" 
            });
        }, 100);
    }

    function setInputState(disabled) {
        input.disabled = disabled;
        sendBtn.disabled = disabled;
        isProcessing = disabled;
    }

    async function sendMessage(msg, options = {}) {
        const {
            showUserMessage = true,
            isGreeting = false
        } = options;

        if (isProcessing || !msg.trim()) return;

        setInputState(true);

        if (showUserMessage) {
            appendMessage(msg, "user");
        }
        
        input.value = "";
        showTypingIndicator();

        try {
            const res = await fetch(API_URL, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ 
                    message: msg, 
                    sessionId: SESSION_ID,
                    isGreeting: isGreeting
                })
            });

            if (!res.ok) {
                throw new Error(`HTTP ${res.status}`);
            }

            const data = await res.json();
            
            removeTypingIndicator();

            const reply = data.reply || data.message || "Xin lỗi, mình không hiểu câu hỏi này.";
            appendMessage(reply, "bot");

        } catch (err) {
            removeTypingIndicator();
            
            console.error('Chat error:', err);
            appendMessage(
                "❌ Không thể kết nối tới server. Vui lòng thử lại sau hoặc liên hệ hotline: 0123-456-789",
                "bot"
            );
        } finally {
            setInputState(false);
            input.focus();
        }
    }

    function initGreeting() {
        if (!hasGreeted) {
            setTimeout(() => {
                sendMessage("xin chào", { 
                    showUserMessage: false,
                    isGreeting: true
                });
                hasGreeted = true;
            }, 500);
        }
    }

    function clearChat() {
        body.innerHTML = '';
        hasGreeted = false;
    }

    window.clearChatbox = clearChat;

    toggle.onclick = () => {
        panel.classList.add("active");
        input.focus();
        
        if (body.children.length === 0) {
            initGreeting();
        }
    };

    closeBtn.onclick = () => {
        panel.classList.remove("active");
    };

    form.onsubmit = async (e) => {
        e.preventDefault();
        const msg = input.value.trim();
        sendMessage(msg, { showUserMessage: true });
    };

    input.onkeydown = (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            form.onsubmit(e);
        }
    };

})();
</script>
