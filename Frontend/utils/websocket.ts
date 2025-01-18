export function initializeWebSocket(onDataCallback: (data: any) => void) {
  const socket = new WebSocket("ws://localhost:3000");

  socket.onopen = () => console.log("WebSocket connected");

  socket.onmessage = (event) => {
    try {
      const data = JSON.parse(event.data);
      console.log("Data received from WebSocket:", data);
      // Controlla se il messaggio è di emergenza
      if (data.misured_value) {
        // Mostra un pop-up per avvisare l'utente
        alert(`Attenzione! Il sensore ${data.sensor} ha superato il limite di ${data.temp_limit ? "temperatura" : "umidità"
          }. Il valore misurato dal sensore è di: "${data.misured_value} ${data.temp_limit ? "°C" : "%"}" (Limite: ${data.temp_limit || data.hum_limit} ${data.temp_limit ? "°C" : "%"})`);
      } else {
        onDataCallback(data);
      }
    } catch (e: any) {
      console.error(e.message);
    }
  };

  socket.onerror = (error) => console.error("WebSocket error:", error);
}
