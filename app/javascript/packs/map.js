// YOLP APIのエンドポイントURLとAPIキー
const endpoint = "https://map.yahooapis.jp/search/local/V1/localSearch";
const apiKey = "YOUR_API_KEY";

// リクエストパラメーター
const params = {
    appid: apiKey,
    lat: 35.681236, // 例：東京の緯度
    lon: 139.767125, // 例：東京の経度
    output: "json" // JSON形式でのレスポンス
};

// URLの構築
const url = new URL(endpoint);
url.search = new URLSearchParams(params).toString();

// APIを呼び出してデータを取得
fetch(url)
    .then(response => response.json())
    .then(data => {
        // レスポンスデータから必要な情報を取得して表示するなどの処理を行う
        console.log(data); // 取得したデータをコンソールに表示
    })
    .catch(error => {
        console.error("Error fetching data:", error);
    });
