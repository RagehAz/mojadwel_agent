
/// is for testing
String webInterfaceHtml() => '''
<html>
  <head>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
      }

      .container {
        text-align: center;
      }

      input {
        width: 400px;
        height: 50px;
        font-size: 18px;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #ccc;
        box-shadow: 1px 1px 5px rgba(0,0,0,0.1);
      }

      button {
        margin-left: 10px;
        height: 50px;
        font-size: 18px;
        padding: 0 20px;
        border-radius: 8px;
        border: none;
        background-color: #007BFF;
        color: white;
        cursor: pointer;
      }

      button:hover {
        background-color: #0056b3;
      }

      .success {
        margin-top: 10px;
        color: green;
        font-weight: bold;
        opacity: 0;
        transition: opacity 0.3s;
      }

      .show {
        opacity: 1;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>Send to Mojadwel</h2>
      <div>
        <input id="msg" placeholder="Type your message" />
        <button onclick="sendMessage()">Send</button>
      </div>
      <div id="success" class="success">Message sent!</div>
    </div>

    <script>
      async function sendMessage() {
        const input = document.getElementById('msg');
        const msg = input.value;
        if (!msg) return;

        try {
          const res = await fetch('/', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({message: msg})
          });
          await res.json();

          // Reset input
          input.value = '';

          // Show success message for 1 second
          const successEl = document.getElementById('success');
          successEl.classList.add('show');
          setTimeout(() => successEl.classList.remove('show'), 1000);
        } catch (err) {
          console.error('Error sending message', err);
        }
      }
    </script>
  </body>
</html>
''';
