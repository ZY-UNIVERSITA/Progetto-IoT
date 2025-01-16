export function initializeWebSocket(onDataCallback: (data: any) => void) {
    const socket = new WebSocket("ws://localhost:3000");
  
    socket.onopen = () => console.log("WebSocket connected");
  
    socket.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        console.log("Data received from WebSocket:", data);
        // Se il dato che arrivo ha temp_limit o hum_limit significa che c'è un problema con i sensori quindi crea un popup di avviso
        if (data.temp_limit || data.hum_limit) {
          alert(`Il sensore ${data.sensor} ha superato il limite di ${data.temp_limit ? "temperatura" : "umidità"} 
                  settata come limite a ${data.temp_limit ? data.temp_limit : data.hum_limit}, 
                  registrando un valore di ${data.temp_limit ? data.temp : data.hum}`);
        } else {
          onDataCallback(data);
        }
      } catch (e: any) {
        console.error(e.message);
      }
    };
  
    socket.onerror = (error) => console.error("WebSocket error:", error);
}
