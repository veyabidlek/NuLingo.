import "dotenv/config";
import express from "express";
import connectDB from "./db";
import globalRouter from "./global-router";
import { logger } from "./logger";
const app = express();
const PORT = process.env.PORT;

connectDB();

app.use(logger);
app.use(express.json());
app.use("/api/", globalRouter);

app.listen(PORT, () => {
  console.log(`Server runs at http://localhost:${PORT}`);
});
