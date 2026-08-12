(function () {
    const panel = document.getElementById('chatbox-panel');
    const toggle = document.getElementById('chatbox-toggle');
    const close = document.getElementById('chatbox-close');
    const body = document.getElementById('chatbox-body');
    const form = document.getElementById('chatbox-form');
    const input = document.getElementById('chatbox-input');

    const API_URL = window.CHATBOX_API_URL || 'http://localhost:8081/api/chat';
    const SESSION_ID = '1';

    function appendMessage(text, sender = "bot") {
        const wrap = document.createElement("div");
        wrap.className = `chat-message ${sender}`;

        const bubble = document.createElement("div");
        bubble.className = "bubble";
        bubble.textContent = text;

        wrap.appendChild(bubble);
        body.appendChild(wrap);

        body.scrollTo({ top: body.scrollHeight, behavior: "smooth" });
    }

    toggle.onclick = () => panel.classList.add("active");
    close.onclick = () => panel.classList.remove("active");

    form.onsubmit = async (e) => {
        e.preventDefault();
        const msg = input.value.trim();
        if (!msg) return;

        appendMessage(msg, "user");
        input.value = "";

        appendMessage("Đang xử lý...", "bot");

        try {
            const res = await fetch(API_URL, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ message: msg, sessionId: SESSION_ID })
            });

            const data = await res.json();
            body.lastElementChild.remove(); 

            appendMessage(data.reply || data.message || "Không có phản hồi.", "bot");

        } catch (err) {
            body.lastElementChild.remove();
            appendMessage("❗ Lỗi kết nối tới server.", "bot");
        }
    };
})();
