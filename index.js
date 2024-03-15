import fetch from "node-fetch";
import { ethers } from "ethers";
import http from "http";

const url =
  "https://api.coingecko.com/api/v3/coins/coq-inu/market_chart?vs_currency=usd&days=1";

const fetchPrice = async () => {
  const resp = await fetch(url);
  const { prices } = await resp.json();
  console.log(prices);
  const slice = prices.slice(-6); // last 30 minutes
  const average = slice.map(([_, price]) => price).reduce((a, b) => a + b) / 6;
  return average;
};

const server = http.createServer(async (request, response) => {
  const price = await fetchPrice();
  response.writeHead(200, { "Content-Type": "application/json" });
  response.end(
    JSON.stringify({
      method: "setPrice",
      args: [ethers.utils.parseUnits(price.toFixed(18)).toString()],
      maxGas: "10000000000000000", // 0.01 ETH
      abort: false,
    })
  );
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

