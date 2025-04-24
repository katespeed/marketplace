const express = require('express');
const app = express();

app.use(express.static('build/web'));

app.get('*', (req, res) => {
  res.sendFile(__dirname + '/build/web/index.html');
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
}); 