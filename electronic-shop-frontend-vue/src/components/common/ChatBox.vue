<template>
    <div>
        <div class="chat-icon" @click="toggleChat">
            <img src="../assets/icon/chat-icon.png" alt="Chat Icon" class="chat-img">
        </div>

        <div v-if="isChatOpen" class="chat-box">
            <!-- Your chat box content goes here -->
            <div class="messages">
                <!-- Display chat messages -->
                <div v-for="message in chatMessages" :key="message.id" class="message">
                    {{ message.sender }}: {{ message.text }}
                </div>
            </div>
            <!-- Input area for sending messages -->
            <div class="input-area">
                <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Type your message..." />
                <button @click="toggleChat">Close Chat</button>
            </div>
        </div>
    </div>
</template>
  
<script>
export default {
    data() {
        return {
            isChatOpen: false,
            chatMessages: [],
            newMessage: '',
        };
    },
    methods: {
        sendMessage() {
            if (this.newMessage.trim() !== '') {
                this.chatMessages.push({
                    id: this.chatMessages.length + 1,
                    sender: 'User',
                    text: this.newMessage.trim(),
                });
                this.newMessage = '';
            }
        },
        toggleChat() {
            this.isChatOpen = !this.isChatOpen;
        },
    },
};
</script>
  
<style scoped>
.chat-icon {
    position: fixed;
    bottom: 20px;
    right: 20px;
    cursor: pointer;
    z-index: 999;
}

.chat-img {
    width: 60px;
    height: auto;
    filter: invert(32%) sepia(63%) saturate(7151%) hue-rotate(166deg) brightness(92%) contrast(86%);
}

.chat-box {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 300px;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    z-index: 998;
}

.messages {
    max-height: 150px;
    overflow-y: auto;
}

.message {
    margin-bottom: 5px;
}

.input-area {
    margin-top: 10px;
}

.input-area input {
    width: 70%;
    padding: 5px;
    margin-right: 5px;
}

.input-area button {
    padding: 5px 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}
</style>
  