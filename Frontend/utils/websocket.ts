export function initializeWebSocket(onDataCallback: (data: any) => void) {
    const socket = new WebSocket("ws://localhost:3000");
  
    socket.onopen = () => console.log("WebSocket connected");
  
    socket.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        console.log("Data received from WebSocket:", data);
        // Controlla se il messaggio è di emergenza
        if (data.limit && (data.temp_limit || data.hum_limit)) {
          // Mostra un pop-up per avvisare l'utente
          alert(`Attenzione! Il sensore ${data.sensor} ha superato il limite di ${
              data.temp_limit ? "temperatura" : "umidità"
          } (${data.limit} > ${data.temp_limit || data.hum_limit})`);
        } else {
          onDataCallback(data);
        }
      } catch (e: any) {
        console.error(e.message);
      }
    };
  
    socket.onerror = (error) => console.error("WebSocket error:", error);
}
